//
//  Created by Florian Mielke on 15.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
 * The FMIStore class manages an application's core data stack.
 */
@interface FMIStore : NSObject

/**
 * An array of entity names that are necessary to check if the persistent store is empty.
 * @see -persistentStoreIsEmpty
 */
@property(NS_NONATOMIC_IOSONLY) NSArray *baseEntityNames;

/**
 * The name of the database file.
 */
@property(copy, NS_NONATOMIC_IOSONLY) NSString *databaseName;

/**
 * The managed object context.
 */
@property(readonly, NS_NONATOMIC_IOSONLY) NSManagedObjectContext *managedObjectContext;

/**
 * The managed object model.
 */
@property(readonly, NS_NONATOMIC_IOSONLY) NSManagedObjectModel *managedObjectModel;

/**
 * The name of the model.
 */
@property(copy, NS_NONATOMIC_IOSONLY) NSString *modelName;

/**
 * The persistent store coordinator.
 */
@property(readonly, NS_NONATOMIC_IOSONLY) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 * A Boolean that indicates whether the persistent store contains any records of the given base entities.
 */
@property(readonly, getter=isPersistentStoreEmpty, NS_NONATOMIC_IOSONLY) BOOL persistentStoreIsEmpty;

/**
 * The iOS application documents directory.
 */
@property(readonly, copy, NS_NONATOMIC_IOSONLY) NSURL *applicationDocumentsDirectory;

/**
 * The OS X application support directory.
 */
@property(readonly, copy, NS_NONATOMIC_IOSONLY) NSURL *applicationSupportDirectory;

/**
 * The NSBundle object that corresponds to the directory where the current application executable is located.
 */
@property(readonly, NS_NONATOMIC_IOSONLY) NSBundle *bundle;

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

@end
