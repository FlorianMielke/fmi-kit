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
@property (NS_NONATOMIC_IOSONLY) NSManagedObjectModel *managedObjectModel;
@property (NS_NONATOMIC_IOSONLY) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation FMIStore

+ (instancetype)sharedStore {
    static FMIStore *singleton;
    static dispatch_once_t singletonToken;
    dispatch_once(&singletonToken, ^{
      singleton = [[self alloc] init];
    });
    return singleton;
}

- (NSString *)databaseName {
    if (_databaseName) {
        return _databaseName;
    }
    _databaseName = [[self.appName stringByAppendingString:@".sqlite"] copy];
    return _databaseName;
}

- (NSString *)modelName {
    if (_modelName) {
        return _modelName;
    }
    _modelName = [self.appName copy];
    return _modelName;
}
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    if (self.persistentStoreCoordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [self.bundle URLForResource:self.modelName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [self persistentStoreCoordinatorWithStoreType:NSSQLiteStoreType storeURL:self.sqliteStoreURL];
    return _persistentStoreCoordinator;
}

- (void)useInMemoryStore {
    _persistentStoreCoordinator = [self persistentStoreCoordinatorWithStoreType:NSInMemoryStoreType storeURL:nil];
}

- (BOOL)saveContext {
    if (!self.managedObjectContext) {
        return NO;
    }
    if (![self.managedObjectContext hasChanges]) {
        return NO;
    }
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error in saving context! %@, %@", error, error.userInfo);
        return NO;
    }
    return YES;
}

- (void)resetPersistentStore {
    [self resetCoreDataStack];
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtURL:self.sqliteStoreURL error:&error];
}

- (void)resetCoreDataStack {
    _managedObjectContext = nil;
    _persistentStoreCoordinator = nil;
    _managedObjectModel = nil;
}

- (BOOL)isPersistentStoreEmpty {
    if ([self.baseEntityNames count] == 0) {
        return NO;
    }
    return [self.managedObjectContext persistentStoreIsEmtpyForEntities:self.baseEntityNames];
}

- (void)deleteAllManagedObjects {
    [self deleteAllObjectsInManagedObjectContext:self.managedObjectContext model:self.managedObjectModel];
}

- (void)deleteAllObjectsInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext model:(NSManagedObjectModel *)model {
    for (NSEntityDescription *entityDescription in model.entities) {
        [self deleteAllObjectsWithEntityName:entityDescription.name inManagedObjectContext:managedObjectContext];
    }
    [managedObjectContext save:NULL];
}

- (void)deleteAllObjectsWithEntityName:(NSString *)entityName inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.includesPropertyValues = NO;
    fetchRequest.includesSubentities = NO;
    NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    for (NSManagedObject *managedObject in items) {
        [managedObjectContext deleteObject:managedObject];
    }
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)applicationSupportDirectory {
    NSURL *appSupportURL = [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:self.appName];
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithStoreType:(NSString *const)storeType storeURL:(NSURL *)storeURL {
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSDictionary *options = @{ NSSQLitePragmasOption : @{@"journal_mode" : @"DELETE"} };
    NSError *error = nil;
    if (![coordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:options error:&error]) {
        NSLog(@"ERROR WHILE CREATING PERSISTENT STORE COORDINATOR! %@, %@", error, error.userInfo);
    }
    return coordinator;
}

- (NSString *)appName {
    return self.bundle.infoDictionary[@"CFBundleName"];
}

- (NSURL *)sqliteStoreURL {
    NSURL *directory = self.isOSX ? self.applicationSupportDirectory : self.applicationDocumentsDirectory;
    NSURL *databaseDir = [directory URLByAppendingPathComponent:self.databaseName];
    [self createApplicationSupportDirIfNeeded:directory];
    return databaseDir;
}

- (BOOL)isOSX {
    return !(NSClassFromString(@"UIDevice"));
}

- (void)createApplicationSupportDirIfNeeded:(NSURL *)url {
    if ([[NSFileManager defaultManager] fileExistsAtPath:url.absoluteString]) {
        return;
    }
    [[NSFileManager defaultManager] createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:nil];
}

- (NSBundle *)bundle {
    return [NSBundle mainBundle];
}

@end
