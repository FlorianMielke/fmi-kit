//
//  FMIStore.m
//
//  Created by Florian Mielke on 15.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIStore.h"
#import "NSManagedObjectContext+PersistentStoreAdditions.h"

NSString *const FMIStoreDidUpdateFromCloudNotification = @"FMIStoreDidUpdateFromCloudNotification";

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

- (BOOL)isPersistentStoreEmpty {
    if (self.baseEntityNames.count == 0) {
        return NO;
    }
    return [self.managedObjectContext persistentStoreIsEmtpyForEntities:self.baseEntityNames];
}

- (NSManagedObjectContext *)createNewManagedObjectContext {
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return managedObjectContext;
}

- (void)useSQLiteStore {
    self.persistentStoreCoordinator = [self persistentStoreCoordinatorWithStoreType:NSSQLiteStoreType storeURL:self.localStoreURL];
    if (self.isICloudEnabled) {
        [self registerForICloudNotifications];
    }
}

- (void)useInMemoryStore {
    self.persistentStoreCoordinator = [self persistentStoreCoordinatorWithStoreType:NSInMemoryStoreType storeURL:nil];
}

#pragma mark - Core Data stack

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithStoreType:(NSString *const)storeType storeURL:(NSURL *)storeURL {
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError *error;
    if (![coordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:self.persistentStoreOptions error:&error]) {
        NSLog(@"Error while creating persistent store coordinator: %@\n%@", error.localizedDescription, error.userInfo);
    }
    return coordinator;
}

- (nullable NSDictionary *)persistentStoreOptions {
    if (self.isICloudEnabled) {
        return @{NSPersistentStoreUbiquitousContentNameKey : @"WorkTimes"};
    }
    return nil;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:self.managedObjectModelURL];
    return _managedObjectModel;
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
        [self.notificationCenter postNotificationName:FMIStoreDidUpdateFromCloudNotification object:self.managedObjectContext userInfo:changeNotification.userInfo];
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
    }];
}

- (void)storesDidChange:(nullable NSNotification *)notification {
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
