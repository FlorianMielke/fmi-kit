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
 * The managed object context.
 */
@property(readonly, NS_NONATOMIC_IOSONLY) NSManagedObjectContext *managedObjectContext;

/**
 * The persistent store coordinator.
 */
@property(readonly, NS_NONATOMIC_IOSONLY) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 * The persistent store options.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSDictionary *persistentStoreOptions;

/**
 * A Boolean that indicates whether the persistent store contains any records of the given base entities.
 */
@property(readonly, getter=isPersistentStoreEmpty, NS_NONATOMIC_IOSONLY) BOOL persistentStoreIsEmpty;

/**
 * The URL to the managed object model.
 */
@property (strong, NS_NONATOMIC_IOSONLY) NSURL *managedObjectModelURL;

/**
 * The URL to the sqlite store.
 */
@property (strong, NS_NONATOMIC_IOSONLY) NSURL *sqliteStoreURL;

/**
 * Returns a shared instance of the FMIStore class.
 *
 * @return A shared instance of the FMIStore class.
 */
+ (FMIStore *)sharedStore;

/**
 * Attempts the managed object context to perform a save.
 *
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
 * Creates a new \c NSManagedObjectContext with the current \c persistentStoreCoordinator
 *
 * @return A new \c NSManagedObjectContext.
 */
- (NSManagedObjectContext *)createNewManagedObjectContext;

@end
