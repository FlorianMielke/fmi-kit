//
//  FMIStore.m
//
//  Created by Florian Mielke on 15.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIStore.h"
#import "FMIStoreConfiguration.h"
#import "FMIKitFactory.h"
#import "FMIFetchCloudStatus.h"
#import "NSPersistentStoreCoordinator+Migration.h"
#import "FMIModifyCloudStatus.h"

NSString *const FMIStoreDidUpdateFromCloudNotification = @"FMIStoreDidUpdateFromCloudNotification";
NSString *const FMIStoreWillChangeStoreNotification = @"FMIStoreWillChangeStoreNotification";
NSString *const FMIStoreDidChangeStoreNotification = @"FMIStoreDidChangeStoreNotification";
NSString *const FMIStoreDidMigrateToCloudStoreNotification = @"FMIStoreDidMigrateToCloudStoreNotification";
NSString *const FMIStoreDidMigrateToLocalStoreNotification = @"FMIStoreDidMigrateToLocalStoreNotification";
NSString *const FMIStoreErrorDomain = @"FMIStoreErrorDomain";

NS_ENUM(NSInteger) {
    FMIStoreErrorUnknown = -1,
    FMIStoreErrorCannotMigrateToCloudStore = -10,
    FMIStoreErrorCannotDestroyLocalStore = -20,
    FMIStoreErrorCannotMigrateToLocalStore = -30,
};

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
    NSDictionary *changedObjectIDs = [changeNotification.userInfo copy];
    [self.managedObjectContext performBlock:^{
        [self.managedObjectContext mergeChangesFromContextDidSaveNotification:changeNotification];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.notificationCenter postNotificationName:FMIStoreDidUpdateFromCloudNotification object:self.managedObjectContext userInfo:changedObjectIDs];
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

- (void)migrateCloudStoreToLocalStoreWithCompletion:(void (^)(BOOL migrated, NSError *error))completionHandler {
    [self storesWillChange:nil] ;
    [self.persistentStoreCoordinator performBlock:^{
        NSError *coordinatorError;
        NSError *error;
        BOOL migrated = NO;
        NSPersistentStore *localStore = [self.persistentStoreCoordinator migratePersistentStore:self.persistentStoreCoordinator.fmi_currentPersistentStore toURL:self.configuration.localStoreURL options:self.configuration.localStoreOptionsForCloudRemoval withType:NSSQLiteStoreType error:&coordinatorError];
        if (localStore) {
            migrated = YES;
            NSLog(@"Migrated to local store.");
        } else {
            error = [NSError errorWithDomain:FMIStoreErrorDomain code:FMIStoreErrorCannotMigrateToLocalStore userInfo:@{NSLocalizedDescriptionKey : @"Failed to migrate to local store.", NSLocalizedRecoverySuggestionErrorKey : @"Please contact me at feedback@madefm.com", NSUnderlyingErrorKey : coordinatorError}];
            NSLog(@"Failed to migrate cloud to local store. Error: %@\n%@", coordinatorError.localizedDescription, coordinatorError.userInfo);
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (completionHandler) {
                completionHandler(migrated, error);
            }
            [self.notificationCenter postNotificationName:FMIStoreDidMigrateToCloudStoreNotification object:self];
        }];
    }];
}

- (void)migrateLocalStoreToCloudStoreWithCompletion:(void (^)(BOOL migrated, NSError *error))completionHandler {
    [self storesWillChange:nil];
    [self.persistentStoreCoordinator performBlock:^{
        NSError *coordinatorError;
        NSError *error;
        BOOL migrated = NO;
        NSPersistentStore *iCloudStore = [self.persistentStoreCoordinator migratePersistentStore:self.persistentStoreCoordinator.fmi_currentPersistentStore toURL:self.configuration.cloudStoreURL options:self.configuration.cloudStoreOptions withType:NSSQLiteStoreType error:&coordinatorError];
        if (iCloudStore) {
            if ([self destroyLocalStoreWithError:&error]) {
                migrated = YES;
                NSLog(@"Migrated to cloud store.");
            }
        } else {
            error = [NSError errorWithDomain:FMIStoreErrorDomain code:FMIStoreErrorCannotMigrateToCloudStore userInfo:@{NSLocalizedDescriptionKey : @"Failed to migrate to cloud store.", NSLocalizedRecoverySuggestionErrorKey : @"Please contact me at feedback@madefm.com", NSUnderlyingErrorKey : coordinatorError}];
            NSLog(@"Failed to migrate local to cloud store. Error: %@\n%@", coordinatorError.localizedDescription, coordinatorError.userInfo);
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (completionHandler) {
                completionHandler(migrated, error);
            }
            [self.notificationCenter postNotificationName:FMIStoreDidMigrateToCloudStoreNotification object:self];
        }];
    }];
}

- (BOOL)destroyLocalStoreWithError:(NSError **)error {
    NSError *coordinatorError;
    BOOL destroyed = [self.persistentStoreCoordinator destroyPersistentStoreAtURL:self.configuration.localStoreURL withType:NSSQLiteStoreType options:self.configuration.localStoreOptions error:&coordinatorError];
    if (!destroyed) {
        (*error) = [NSError errorWithDomain:FMIStoreErrorDomain code:FMIStoreErrorCannotDestroyLocalStore userInfo:@{NSLocalizedDescriptionKey : @"Failed to destroy local store.", NSUnderlyingErrorKey : coordinatorError}];
        NSLog(@"Failed to destroy local store. Error: %@\n%@", coordinatorError.localizedDescription, coordinatorError.userInfo);
    }
    return destroyed;
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

@end
