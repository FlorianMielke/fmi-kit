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
#import "NSFileManager+DirectoryAdditions.h"

NSString *const FMIStoreWillChangeStoreNotification = @"FMIStoreWillChangeStoreNotification";
NSString *const FMIStoreDidChangeStoreNotification = @"FMIStoreDidChangeStoreNotification";
NSString *const FMIStoreDidMigrateToCloudStoreNotification = @"FMIStoreDidMigrateToCloudStoreNotification";
NSString *const FMIStoreDidMigrateToLocalStoreNotification = @"FMIStoreDidMigrateToLocalStoreNotification";
NSString *const FMIStoreErrorDomain = @"FMIStoreErrorDomain";

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
}

- (void)deregisterFromICloudNotifications {
    [self.notificationCenter removeObserver:self name:NSPersistentStoreCoordinatorStoresWillChangeNotification object:self.persistentStoreCoordinator];
    [self.notificationCenter removeObserver:self name:NSPersistentStoreCoordinatorStoresDidChangeNotification object:self.persistentStoreCoordinator];
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

- (BOOL)destroyLocalStoreWithError:(NSError **)error {
    NSError *coordinatorError;
    BOOL destroyed = [self.persistentStoreCoordinator destroyPersistentStoreAtURL:self.configuration.localStoreURL withType:NSSQLiteStoreType options:self.configuration.localStoreOptions error:&coordinatorError];
    if (!destroyed) {
        (*error) = [NSError errorWithDomain:FMIStoreErrorDomain code:FMIStoreErrorCannotDestroyLocalStore userInfo:@{NSLocalizedDescriptionKey : @"Failed to destroy local store.", NSUnderlyingErrorKey : coordinatorError}];
        NSLog(@"Failed to destroy local store. Error: %@\n%@", coordinatorError.localizedDescription, coordinatorError.userInfo);
    }
    return destroyed;
}

@end
