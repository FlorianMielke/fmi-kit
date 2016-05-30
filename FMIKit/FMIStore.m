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
#import "NSPersistentStoreCoordinator+Migration.h"

NSString *const FMIStoreDidUpdateFromCloudNotification = @"FMIStoreDidUpdateFromCloudNotification";
NSString *const FMIStoreWillChangeStoreNotification = @"FMIStoreWillChangeStoreNotification";
NSString *const FMIStoreDidChangeStoreNotification = @"FMIStoreDidChangeStoreNotification";
NSString *const FMIStoreCloudEnabledKey = @"FMIStoreCloudEnabledKey";

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
    [self.persistentStoreCoordinator performBlockAndWait:^{
        NSError *error;
        for (NSPersistentStore *store in self.persistentStoreCoordinator.persistentStores) {
            BOOL removed = [self.persistentStoreCoordinator removePersistentStore:store error:&error];
            if (!removed) {
                NSLog(@"Failed to remove persistent store. Error: %@\n%@", error.localizedDescription, error.userInfo);
            }
        }
    }];
}

- (NSManagedObjectContext *)createNewManagedObjectContext {
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;;
    managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return managedObjectContext;
}

- (void)useSQLiteStoreWithConfiguration:(FMIStoreConfiguration *)configuration {
    self.configuration = configuration;
    [self preparePersistentStoreCoordinatorWithStoreType:NSSQLiteStoreType storeURL:self.configuration.currentStoreURL];
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
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:self.configuration.currentStoreOptions error:&error]) {
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
    [self.persistentStoreCoordinator performBlock:^{
        NSDictionary *localStoreOptions = [self localStoreOptionsWithCloudRemovalMetadataOption];
        NSError *error;
        NSPersistentStore *localStore = [self.persistentStoreCoordinator migratePersistentStore:[self.persistentStoreCoordinator fmi_currentPersistentStore] toURL:self.configuration.localStoreURL options:localStoreOptions withType:NSSQLiteStoreType error:&error];
        if (!localStore) {
            NSLog(@"Failed to migrate cloud to local store. Error: %@\n%@", error.localizedDescription, error.userInfo);
        } else {
            NSLog(@"Migrated to local store.");
        }
    }];
}

- (void)migrateLocalStoreToICloudStore {
    [self storesWillChange:nil];
    [self.persistentStoreCoordinator performBlock:^{
        if ([self isICloudEnabled]) {
            if (![self destroyLocalStore]) {
                return;
            }
            NSError *error;
            NSPersistentStore *localStore = [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.configuration.localStoreURL options:self.configuration.localStoreOptions error:&error];
            if (!localStore) {
                NSLog(@"Failed to add local store after destroying it. Error: %@\n%@", error.localizedDescription, error.userInfo);
                return;
            }
        }
        NSError *error;
        NSPersistentStore *iCloudStore = [self.persistentStoreCoordinator migratePersistentStore:[self.persistentStoreCoordinator fmi_currentPersistentStore] toURL:self.configuration.cloudStoreURL options:self.configuration.cloudStoreOptions withType:NSSQLiteStoreType error:&error];
        if (!iCloudStore) {
            NSLog(@"Failed to migrate local to cloud store. Error: %@\n%@", error.localizedDescription, error.userInfo);
        } else {
            [self storeICloudEnabledStatus];
            if ([self destroyLocalStore]) {
                NSLog(@"Migrated to cloud and destroyed local store.");
            }
        }
    }];
}

- (BOOL)destroyLocalStore {
    NSError *destroyingError;
    BOOL isDestroyed = [self.persistentStoreCoordinator destroyPersistentStoreAtURL:self.configuration.localStoreURL withType:NSSQLiteStoreType options:self.configuration.localStoreOptions error:&destroyingError];
    if (!isDestroyed) {
        NSLog(@"Failed to destroy local store file. Error: %@\n%@", destroyingError.localizedDescription, destroyingError.userInfo);
    } else {
        NSLog(@"Destroyed (removed) local store.");
    }
    return isDestroyed;
}

- (BOOL)resetICloudStoreIfNeeded {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        BOOL success = [NSPersistentStoreCoordinator removeUbiquitousContentAndPersistentStoreAtURL:self.configuration.cloudStoreURL options:self.configuration.cloudStoreOptions error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!success) {
                NSLog(@"Failed to reset cloud store. Error: %@\n%@", error.localizedDescription, error.userInfo);
            } else {
                NSLog(@"Finished resetting cloud store");
            }
        });
    });
    return YES;
}

- (NSDictionary *)localStoreOptionsWithCloudRemovalMetadataOption {
    NSMutableDictionary *localStoreOptions = [self.configuration.localStoreOptions mutableCopy];
    localStoreOptions[NSPersistentStoreRemoveUbiquitousMetadataOption] = @YES;
    return [localStoreOptions copy];
}

- (void)storeICloudEnabledStatus {
    [[NSUbiquitousKeyValueStore defaultStore] setBool:YES forKey:FMIStoreCloudEnabledKey];
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
}

- (BOOL)isICloudEnabled {
    return [[NSUbiquitousKeyValueStore defaultStore] boolForKey:FMIStoreCloudEnabledKey];
}

@end
