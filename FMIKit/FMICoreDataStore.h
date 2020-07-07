//
//  Created by Florian Mielke on 15.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import CoreData;
#import <FMIKit/FMIStore.h>

@class FMICoreDataStoreConfiguration;

NS_ASSUME_NONNULL_BEGIN

OBJC_EXTERN NSString *const FMIStoreWillChangeStoreNotification;
OBJC_EXTERN NSString *const FMIStoreDidChangeStoreNotification;

NS_ENUM(NSInteger) {
  FMIStoreErrorUnknown = -1,
  FMIStoreErrorCannotDestroyLocalStore = -20,
  FMIStoreErrorCannotMigrateToLocalStore = -30,
};

/**
 * The FMIStore class manages an application's core data stack.
 */
@interface FMICoreDataStore : NSObject <FMIStore>

/**
 * The assigned store configuration.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) FMICoreDataStoreConfiguration *configuration;

/**
 * The managed object context.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSManagedObjectContext *managedObjectContext;

/**
 * The persistent store coordinator.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 * Returns a shared instance of the FMIStore class.
 *
 * @return A shared instance of the FMIStore class.
 */
+ (FMICoreDataStore *)sharedStore;

/**
 * Forces the store to use a SQLite store.
 *
 * @param configuration The stores configuration.
 */
- (void)useSQLiteStoreWithConfiguration:(FMICoreDataStoreConfiguration *)configuration;

/**
 * Forces the store to use an in memory store.
 *
 * @param configuration The stores configuration.
 */
- (void)useInMemoryStoreWithConfiguration:(FMICoreDataStoreConfiguration *)configuration;

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

NS_ASSUME_NONNULL_END
