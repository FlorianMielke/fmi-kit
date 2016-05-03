//
//  FMIStore.m
//
//  Created by Florian Mielke on 15.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIStore.h"
#import "NSManagedObjectContext+PersistentStoreAdditions.h"

@interface FMIStore ()

@property (NS_NONATOMIC_IOSONLY) NSManagedObjectContext *managedObjectContext;
@property (NS_NONATOMIC_IOSONLY) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (NS_NONATOMIC_IOSONLY) NSManagedObjectModel *managedObjectModel;

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

- (void)resetPersistentStore {
    [self resetCoreDataStack];
    NSError *error;
    if (![[NSFileManager defaultManager] removeItemAtURL:self.sqliteStoreURL error:&error]) {
        NSLog(@"Failed to remove persistent store: %@\n%@", error.localizedDescription, error.userInfo);
    }
}

- (void)resetCoreDataStack {
    self.managedObjectContext = nil;
    self.persistentStoreCoordinator = nil;
    self.managedObjectModel = nil;
}

- (BOOL)isPersistentStoreEmpty {
    if (self.baseEntityNames.count == 0) {
        return NO;
    }
    return [self.managedObjectContext persistentStoreIsEmtpyForEntities:self.baseEntityNames];
}

- (NSDictionary *)persistentStoreOptions {
    NSPersistentStore *persistentStore = self.persistentStoreCoordinator.persistentStores.firstObject;
    return [persistentStore.options copy];
}

- (NSManagedObjectContext *)createNewManagedObjectContext {
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    return managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithStoreType:(NSString *const)storeType storeURL:(NSURL *)storeURL {
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSDictionary *options = [self buildPersistentStoreOptions];
    NSError *error;
    if (![coordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:options error:&error]) {
        NSLog(@"Error while creating persistent store coordinator: %@\n%@", error.localizedDescription, error.userInfo);
    }
    return coordinator;
}

- (NSDictionary *)buildPersistentStoreOptions {
    if (self.isICloudEnabled) {
        return @{NSPersistentStoreUbiquitousContentNameKey : @"WorkTimes", NSMigratePersistentStoresAutomaticallyOption : @YES, NSInferMappingModelAutomaticallyOption : @YES, @"journal_mode" : @"DELETE"};
    }
    return @{NSMigratePersistentStoresAutomaticallyOption : @YES, NSInferMappingModelAutomaticallyOption : @YES, @"journal_mode" : @"DELETE"};
}

- (void)useInMemoryStore {
    self.persistentStoreCoordinator = [self persistentStoreCoordinatorWithStoreType:NSInMemoryStoreType storeURL:nil];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    if (self.persistentStoreCoordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:self.managedObjectModelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [self persistentStoreCoordinatorWithStoreType:NSSQLiteStoreType storeURL:self.sqliteStoreURL];
    if (self.isICloudEnabled) {
        [self registerForICloudNotifications];
    }
    return _persistentStoreCoordinator;
}

#pragma mark - iCloud

- (void)registerForICloudNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(storesWillChange:) name:NSPersistentStoreCoordinatorStoresWillChangeNotification object:self.persistentStoreCoordinator];
    [notificationCenter addObserver:self selector:@selector(storesDidChange:) name:NSPersistentStoreCoordinatorStoresDidChangeNotification object:self.persistentStoreCoordinator];
    [notificationCenter addObserver:self selector:@selector(persistentStoreDidImportUbiquitousContentChanges:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:self.persistentStoreCoordinator];
}

- (void)persistentStoreDidImportUbiquitousContentChanges:(NSNotification *)changeNotification {
    NSManagedObjectContext *context = self.managedObjectContext;
    [context performBlock:^{
        [context mergeChangesFromContextDidSaveNotification:changeNotification];
    }];
}

- (void)storesWillChange:(NSNotification *)notification {
    NSManagedObjectContext *context = self.managedObjectContext;
    [context performBlockAndWait:^{
        NSError *error;
        if (context.hasChanges) {
            BOOL success = [context save:&error];
            if (!success && error) {
                NSLog(@"Failed saving context after NSPersistentStoreCoordinatorStores change. Error: %@\n%@", error.localizedDescription, error.userInfo);
            }
        }
        [context reset];
    }];
    [self storesDidChange:nil];
}

- (void)storesDidChange:(nullable NSNotification *)notification {
    NSLog(@"(%s): %@", __PRETTY_FUNCTION__, notification.userInfo);
}

- (void)migrateiCloudStoreToLocalStore {
    self.enableICloud = NO;
    NSPersistentStore *store = self.persistentStoreCoordinator.persistentStores.firstObject;
    NSMutableDictionary *localStoreOptions = [self.persistentStoreOptions mutableCopy];
    localStoreOptions[NSPersistentStoreRemoveUbiquitousMetadataOption] = @YES;
    NSPersistentStore *newStore =  [self.persistentStoreCoordinator migratePersistentStore:store toURL:self.sqliteStoreURL options:localStoreOptions withType:NSSQLiteStoreType error:nil];
    [self reloadStore:newStore];
}

- (void)reloadStore:(NSPersistentStore *)store {
    if (store) {
        [self.persistentStoreCoordinator removePersistentStore:store error:nil];
    }
    [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.sqliteStoreURL options:[self buildPersistentStoreOptions] error:nil];
}

@end
