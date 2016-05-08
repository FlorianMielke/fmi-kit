//
//  FMIStore.m
//
//  Created by Florian Mielke on 15.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIStore.h"
#import "NSManagedObjectContext+PersistentStoreAdditions.h"

NSString *const FMIStoreDidUpdateFromCloudNotification = @"FMIStoreDidUpdateFromCloudNotification";
NSString *const FMIStoreWillChangeStoreNotification = @"FMIStoreWillChangeStoreNotification";
NSString *const FMIStoreDidChangeStoreNotification = @"FMIStoreDidChangeStoreNotification";

@interface FMIStore ()

@property (NS_NONATOMIC_IOSONLY) NSManagedObjectContext *managedObjectContext;
@property (NS_NONATOMIC_IOSONLY) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (NS_NONATOMIC_IOSONLY) NSManagedObjectModel *managedObjectModel;
@property (NS_NONATOMIC_IOSONLY) NSNotificationCenter *notificationCenter;

@end

@implementation FMIStore

+ (FMIStore *)sharedStore {
    static FMIStore *singleton;
    static dispatch_once_t singletonToken;
    dispatch_once(&singletonToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.enableICloud = NO;
        self.notificationCenter = [NSNotificationCenter defaultCenter];
    }
    return self;
}

- (BOOL)saveContext {
    if (!self.managedObjectContext || !self.managedObjectContext.hasChanges) {
        return NO;
    }
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error in saving context: %@\n%@", error.localizedDescription, error.userInfo);
        return NO;
    }
    return YES;
}

- (void)resetCoreDataStack {
    [self deregisterFromICloudNotifications];
    [self.managedObjectContext reset];
    [self removePersistentStoresFromCoordinator];
}

- (void)removePersistentStoresFromCoordinator {
    NSError *error;
    for (NSPersistentStore *store in self.persistentStoreCoordinator.persistentStores) {
        BOOL removed = [self.persistentStoreCoordinator removePersistentStore:store error:&error];
        if (!removed) {
            NSLog(@"Failed to remove persistent store. Error: %@\n%@", error.localizedDescription, error.userInfo);
        }
    }
}

- (NSManagedObjectContext *)createNewManagedObjectContext {
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return managedObjectContext;
}

- (void)useSQLiteStore {
    [self preparePersistentStoreCoordinatorWithStoreType:NSSQLiteStoreType storeURL:self.localStoreURL];
}

- (void)useInMemoryStore {
    [self preparePersistentStoreCoordinatorWithStoreType:NSInMemoryStoreType storeURL:nil];
}

- (void)preparePersistentStoreCoordinatorWithStoreType:(NSString *const)storeType storeURL:(NSURL *)storeURL {
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:self.managedObjectModelURL];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (self.isICloudEnabled) {
        [self registerForICloudNotifications];
    }
    NSError *error;
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:self.persistentStoreOptions error:&error]) {
        NSLog(@"Error while creating persistent store coordinator: %@\n%@", error.localizedDescription, error.userInfo);
        return;
    }
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
}

- (nullable NSDictionary *)persistentStoreOptions {
    if (self.isICloudEnabled) {
        return @{NSPersistentStoreUbiquitousContentNameKey : @"WorkTimes"};
    }
    return nil;
}

#pragma mark - iCloud

- (void)registerForICloudNotifications {
    [self.notificationCenter addObserver:self selector:@selector(storesWillChange:) name:NSPersistentStoreCoordinatorStoresWillChangeNotification object:self.persistentStoreCoordinator];
    [self.notificationCenter addObserver:self selector:@selector(storesDidChange:) name:NSPersistentStoreCoordinatorStoresDidChangeNotification object:self.persistentStoreCoordinator];
    [self.notificationCenter addObserver:self selector:@selector(persistentStoreDidImportUbiquitousContentChanges:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:self.persistentStoreCoordinator];
}

- (void)deregisterFromICloudNotifications {
    [self.notificationCenter removeObserver:self name:NSPersistentStoreCoordinatorStoresWillChangeNotification object:self.persistentStoreCoordinator];
    [self.notificationCenter removeObserver:self name:NSPersistentStoreCoordinatorStoresDidChangeNotification object:self.persistentStoreCoordinator];
    [self.notificationCenter removeObserver:self name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:self.persistentStoreCoordinator];
}

- (void)persistentStoreDidImportUbiquitousContentChanges:(NSNotification *)changeNotification {
    NSManagedObjectContext *context = self.managedObjectContext;
    [context performBlock:^{
        [context mergeChangesFromContextDidSaveNotification:changeNotification];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.notificationCenter postNotificationName:FMIStoreDidUpdateFromCloudNotification object:self.managedObjectContext userInfo:changeNotification.userInfo];
        }];
    }];
}

- (void)storesWillChange:(NSNotification *)notification {
    NSLog(@"(%s): %@", __PRETTY_FUNCTION__, notification.userInfo);
    NSManagedObjectContext *context = self.managedObjectContext;
    [context performBlockAndWait:^{
        NSError *error;
        if (context.hasChanges) {
            if (![context save:&error]) {
                NSLog(@"Failed saving context after NSPersistentStoreCoordinatorStores change. Error: %@\n%@", error.localizedDescription, error.userInfo);
            }
        }
        [context reset];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.notificationCenter postNotificationName:FMIStoreWillChangeStoreNotification object:self];
        }];
    }];
}

- (void)storesDidChange:(nullable NSNotification *)notification {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.notificationCenter postNotificationName:FMIStoreDidChangeStoreNotification object:self];
    }];
    NSLog(@"(%s): %@", __PRETTY_FUNCTION__, notification.userInfo);
}

- (void)migrateICloudStoreToLocalStore {
    NSError *error;
    NSPersistentStore *store = self.persistentStoreCoordinator.persistentStores.firstObject;
    NSDictionary *resetStoreOptions = @{NSPersistentStoreRemoveUbiquitousMetadataOption : @YES};
    NSPersistentStore *localStore = [self.persistentStoreCoordinator migratePersistentStore:store toURL:self.localStoreURL options:resetStoreOptions withType:NSSQLiteStoreType error:&error];
    if (!localStore) {
        NSLog(@"Failed to migrate iCloud to local store. Error: %@\n%@", error.localizedDescription, error.userInfo);
    }
    [self reloadStore:localStore];
}

- (void)migrateLocalStoreToICloudStore {
    [self resetCoreDataStack];
    [self useSQLiteStore];
}

- (void)reloadStore:(NSPersistentStore *)store {
    [self.persistentStoreCoordinator removePersistentStore:store error:nil];
    [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.localStoreURL options:self.persistentStoreOptions error:nil];
}

@end
