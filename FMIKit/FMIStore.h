//
//  Created by Florian Mielke on 15.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import CoreData;

/**
 * The FMIStore class manages an application's core data stack.
 */
@interface FMIStore : NSObject

/**
 * An array of entity names that are necessary to check if the persistent store is empty.
 * @see -persistentStoreIsEmpty
 */
@property (nonatomic, strong) NSArray *baseEntityNames;

/**
 * The name of the database file.
 */
@property (nonatomic, copy) NSString *databaseName;

/**
 * The managed object context.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

/**
 * The managed object model.
 */
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;

/**
 * The name of the model.
 */
@property (nonatomic, copy) NSString *modelName;

/**
 * The persisent store coordinator.
 */
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 * Returns a shared instance of the FMIStore class.
 * @return A shared instance of the FMIStore class.
 */
+ (instancetype)sharedStore;

/**
 * Attempts the managed object context to perform a save.
 * @return YES if the save succeeds, otherwise NO.
 */
- (BOOL)saveContext;

/**
 * Forces the manager to use an in memory store.
 */
- (void)useInMemoryStore;

/**
 * Removes the database file from the file system.
 */
- (void)resetPersistentStore;

/**
 * Resets the whole Core Data stack.
 */
- (void)resetCoreDataStack;

/**
 * Deletes all managed objects from the persistent store.
 */
- (void)deleteAllManagedObjects;

/**
 * Returns a Boolean that indicates whether the persistent store contains any records of the given base entities.
 * @return YES if the store is empty, otherwise NO or if baseEntityNames is nil.
 */
- (BOOL)persistentStoreIsEmpty;

/**
 * The iOS application documents directory.
 * @return The URL to the application documents directory.
 */
- (NSURL *)applicationDocumentsDirectory;

/**
 * The OS X application support directory.
 * @return The URL to the application support directory.
 */
- (NSURL *)applicationSupportDirectory;

/**
 * Returns the NSBundle object that corresponds to the directory where the current application executable is located.
 * @return The NSBundle object that corresponds to the directory where the application executable is located, or nil if a bundle object could not be created.
 */
- (NSBundle *)bundle;

@end
