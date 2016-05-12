//
//  FMIStore.m
//
//  Created by Florian Mielke on 15.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIStore.h"
#import "NSFileManager+DirectoryAdditions.h"
#import "NSManagedObjectContext+PersistentStoreAdditions.h"
#import "FMIStoreConfiguration.h"

NSString *const FMIStoreDidUpdateFromCloudNotification = @"FMIStoreDidUpdateFromCloudNotification";
NSString *const FMIStoreWillChangeStoreNotification = @"FMIStoreWillChangeStoreNotification";
NSString *const FMIStoreDidChangeStoreNotification = @"FMIStoreDidChangeStoreNotification";

@interface FMIStore ()

@property (NS_NONATOMIC_IOSONLY) NSManagedObjectContext *managedObjectContext;
@property (NS_NONATOMIC_IOSONLY) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (NS_NONATOMIC_IOSONLY) NSManagedObjectModel *managedObjectModel;
@property (NS_NONATOMIC_IOSONLY) NSNotificationCenter *notificationCenter;
@property (getter=isICloudEnabled, NS_NONATOMIC_IOSONLY) BOOL enableICloud;
@property (NS_NONATOMIC_IOSONLY) FMIStoreConfiguration *configuration;

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
    managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;;
    managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return managedObjectContext;
}

- (void)useSQLiteStoreWithConfiguration:(FMIStoreConfiguration *)configuration {
    self.configuration = configuration;
    self.enableICloud = (configuration.cloudStatus == FMICloudStatusEnabled);
    [self preparePersistentStoreCoordinatorWithStoreType:NSSQLiteStoreType storeURL:self.configuration.localStoreURL];
}

- (void)useInMemoryStoreWithConfiguration:(FMIStoreConfiguration *)configuration {
    [self preparePersistentStoreCoordinatorWithStoreType:NSInMemoryStoreType storeURL:nil];
}

- (void)preparePersistentStoreCoordinatorWithStoreType:(NSString *const)storeType storeURL:(NSURL *)storeURL {
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:self.configuration.managedObjectModelURL];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    [self registerForICloudNotifications];
    NSError *error;
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:self.persistentStoreOptions error:&error]) {
        NSLog(@"Error while creating persistent store coordinator: %@\n%@", error.localizedDescription, error.userInfo);
        return;
    }
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
}

- (NSDictionary *)persistentStoreOptions {
    if (self.isICloudEnabled) {
        return self.configuration.cloudStoreOptions;
    }
    return self.configuration.localStoreOptions;
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
            [self.notificationCenter postNotificationName:FMIStoreDidUpdateFromCloudNotification object:self];
        }];
    }];
}

- (void)storesWillChange:(NSNotification *)notification {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.notificationCenter postNotificationName:FMIStoreWillChangeStoreNotification object:self];
    }];
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
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.notificationCenter postNotificationName:FMIStoreDidChangeStoreNotification object:self];
    }];
}

- (void)migrateICloudStoreToLocalStore {
    self.enableICloud = NO;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSPersistentStore *cloudStore = self.persistentStoreCoordinator.persistentStores.firstObject;
        NSDictionary *cloudStoreOptions = [cloudStore.options copy];
        NSError *error;
        NSMutableDictionary *localStoreOptions = [cloudStore.options mutableCopy];
        [localStoreOptions addEntriesFromDictionary:@{NSPersistentStoreRemoveUbiquitousMetadataOption : @YES}];
        NSPersistentStore *localStore = [self.persistentStoreCoordinator migratePersistentStore:cloudStore toURL:self.configuration.localStoreURL options:localStoreOptions withType:NSSQLiteStoreType error:&error];
        if (!localStore) {
            NSLog(@"Failed to migrate cloud to local store. Error: %@\n%@", error.localizedDescription, error.userInfo);
        } else {
            NSError *removingError;
            BOOL isDestroyed = [self.persistentStoreCoordinator destroyPersistentStoreAtURL:self.configuration.cloudStoreURL withType:NSSQLiteStoreType options:cloudStoreOptions error:&removingError];
            if (!isDestroyed) {
                NSLog(@"Failed to destroy cloud store file. Error: %@\n%@", error.localizedDescription, error.userInfo);
            } else {
                NSLog(@"Migrated to local store and destroyed cloud store");
            }
        }
    }];
}

- (void)migrateLocalStoreToICloudStore {
    self.enableICloud = YES;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSPersistentStore *localeStore = self.persistentStoreCoordinator.persistentStores.firstObject;
        NSDictionary *localStoreOptions = [localeStore.options copy];
        NSError *error;
        NSPersistentStore *iCloudStore = [self.persistentStoreCoordinator migratePersistentStore:localeStore toURL:self.configuration.cloudStoreURL options:self.persistentStoreOptions withType:NSSQLiteStoreType error:&error];
        if (!iCloudStore) {
            NSLog(@"Failed to migrate local to cloud store. Error: %@\n%@", error.localizedDescription, error.userInfo);
        } else {
            NSError *removingError;
            BOOL isDestroyed = [self.persistentStoreCoordinator destroyPersistentStoreAtURL:self.configuration.localStoreURL withType:NSSQLiteStoreType options:localStoreOptions error:&removingError];
            if (!isDestroyed) {
                NSLog(@"Failed to destroy locale store file. Error: %@\n%@", error.localizedDescription, error.userInfo);
            } else {
                NSLog(@"Migrated to cloud and destroyed legacy locale store");
            }
        }
    }];
}

- (BOOL)resetICloudStoreIfNeeded {
    if (!self.isICloudEnabled) {
        return NO;
    }
    NSPersistentStore *cloudStore = self.persistentStoreCoordinator.persistentStores.firstObject;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        BOOL success = [NSPersistentStoreCoordinator removeUbiquitousContentAndPersistentStoreAtURL:cloudStore.URL options:cloudStore.options error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!success) {
                NSLog(@"Failed to reset cloud store. Error: %@\n%@", error.localizedDescription, error.userInfo);
            } else {
                self.enableICloud = NO;
                NSLog(@"Finished");
            }
        });

    });
    return YES;
}

@end
