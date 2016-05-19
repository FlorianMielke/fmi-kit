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
#import "FMIKitFactory.h"
#import "FMIFetchCloudStatus.h"

NSString *const FMIStoreDidUpdateFromCloudNotification = @"FMIStoreDidUpdateFromCloudNotification";
NSString *const FMIStoreWillChangeStoreNotification = @"FMIStoreWillChangeStoreNotification";
NSString *const FMIStoreDidChangeStoreNotification = @"FMIStoreDidChangeStoreNotification";

@interface FMIStore ()

@property (NS_NONATOMIC_IOSONLY) NSManagedObjectContext *managedObjectContext;
@property (NS_NONATOMIC_IOSONLY) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (NS_NONATOMIC_IOSONLY) NSManagedObjectModel *managedObjectModel;
@property (NS_NONATOMIC_IOSONLY) NSNotificationCenter *notificationCenter;
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
        self.notificationCenter = [NSNotificationCenter defaultCenter];
    }
    return self;
}

- (BOOL)saveContext {
    if (!self.managedObjectContext || !self.managedObjectContext.hasChanges) {
        return NO;
    }
    __block BOOL saved = YES;
    [self.managedObjectContext performBlockAndWait:^{
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error in saving context: %@\n%@", error.localizedDescription, error.userInfo);
            saved = NO;
        }
    }];
    return saved;
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
    [self preparePersistentStoreCoordinatorWithStoreType:NSSQLiteStoreType storeURL:self.persistentStoreURL];
}

- (void)useInMemoryStoreWithConfiguration:(FMIStoreConfiguration *)configuration {
    self.configuration = configuration;
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
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, changeNotification.userInfo);
    [self.managedObjectContext performBlock:^{
        [self.managedObjectContext mergeChangesFromContextDidSaveNotification:changeNotification];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.notificationCenter postNotificationName:FMIStoreDidUpdateFromCloudNotification object:self];
        }];
    }];
}

- (void)storesWillChange:(nullable NSNotification *)notification {
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, notification.userInfo);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.notificationCenter postNotificationName:FMIStoreWillChangeStoreNotification object:self];
    }];
    [self.managedObjectContext performBlockAndWait:^{
        NSError *error;
        if (self.managedObjectContext.hasChanges) {
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Failed saving context after NSPersistentStoreCoordinatorStores change. Error: %@\n%@", error.localizedDescription, error.userInfo);
            }
        }
        [self.managedObjectContext reset];
    }];
}

- (void)storesDidChange:(nullable NSNotification *)notification {
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, notification.userInfo);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.notificationCenter postNotificationName:FMIStoreDidChangeStoreNotification object:self];
    }];
}

- (void)migrateICloudStoreToLocalStore {
    [self storesWillChange:nil];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSPersistentStore *cloudStore = self.persistentStoreCoordinator.persistentStores.firstObject;
        NSError *error;
        NSMutableDictionary *localStoreOptions = [self.configuration.localStoreOptions mutableCopy];
        [localStoreOptions addEntriesFromDictionary:@{NSPersistentStoreRemoveUbiquitousMetadataOption : @YES}];
        NSPersistentStore *localStore = [self.persistentStoreCoordinator migratePersistentStore:cloudStore toURL:self.configuration.localStoreURL options:localStoreOptions withType:NSSQLiteStoreType error:&error];
        if (!localStore) {
            NSLog(@"Failed to migrate cloud to local store. Error: %@\n%@", error.localizedDescription, error.userInfo);
        } else {
            NSError *destroyingError;
            BOOL isDestroyed = [self.persistentStoreCoordinator destroyPersistentStoreAtURL:self.configuration.cloudStoreURL withType:NSSQLiteStoreType options:self.configuration.cloudStoreOptions error:&destroyingError];
            if (!isDestroyed) {
                NSLog(@"Failed to destroy cloud store file. Error: %@\n%@", destroyingError.localizedDescription, destroyingError.userInfo);
            } else {
                BOOL removedCloudStores = [[NSFileManager defaultManager] fmi_removeCloudStoresAtURL:self.configuration.cloudStoreURL];
                if (removedCloudStores) {
                    NSLog(@"Migrated to local and destroyed (removed) cloud store.");
                }
            }
        }
    }];
}

- (void)migrateLocalStoreToICloudStore {
    [self storesWillChange:nil];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSPersistentStore *localStore = self.persistentStoreCoordinator.persistentStores.firstObject;
        NSDictionary *localStoreOptions = [localStore.options copy];
        NSError *error;
        NSPersistentStore *iCloudStore = [self.persistentStoreCoordinator migratePersistentStore:localStore toURL:self.configuration.cloudStoreURL options:self.configuration.cloudStoreOptions withType:NSSQLiteStoreType error:&error];
        if (!iCloudStore) {
            NSLog(@"Failed to migrate local to cloud store. Error: %@\n%@", error.localizedDescription, error.userInfo);
        } else {
            NSError *destroyingError;
            BOOL isDestroyed = [self.persistentStoreCoordinator destroyPersistentStoreAtURL:self.configuration.localStoreURL withType:NSSQLiteStoreType options:localStoreOptions error:&destroyingError];
            if (!isDestroyed) {
                NSLog(@"Failed to destroy local store file. Error: %@\n%@", destroyingError.localizedDescription, destroyingError.userInfo);
            } else {
                NSError *removingError;
                BOOL removed = [[NSFileManager defaultManager] removeItemAtURL:self.configuration.localStoreURL error:&removingError];
                if (!removed) {
                    NSLog(@"Failed to remove local store. Error: %@\n%@", removingError.localizedDescription, removingError.userInfo);
                } else {
                    NSLog(@"Migrated to cloud and destroyed (removed) local store.");
                }
            }
        }
    }];
}

- (BOOL)resetICloudStoreIfNeeded {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        BOOL success = [NSPersistentStoreCoordinator removeUbiquitousContentAndPersistentStoreAtURL:self.configuration.cloudStoreURL options:self.configuration.cloudStoreOptions error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!success) {
                NSLog(@"Failed to reset cloud store. Error: %@\n%@", error.localizedDescription, error.userInfo);
            } else {
                NSLog(@"Finished reseting cloud store");
            }
        });
    });
    return YES;
}

- (NSURL *)persistentStoreURL {
    if ([self determineCloudStatus] == FMICloudStatusEnabled) {
        return self.configuration.cloudStoreURL;
    }
    return self.configuration.localStoreURL;
}

- (NSDictionary *)persistentStoreOptions {
    if ([self determineCloudStatus] == FMICloudStatusEnabled) {
        return self.configuration.cloudStoreOptions;
    }
    return self.configuration.localStoreOptions;
}

- (NSPersistentStore *)currentPersistentStore {
    return self.persistentStoreCoordinator.persistentStores.firstObject;
}

- (FMICloudStatus)determineCloudStatus {
    return [[FMIKitFactory createFetchCloudStatus] fetchCloudStatus];
}

@end
