//
//  Created by Florian Mielke on 15.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FMICloudStatus.h"

@class FMIStoreConfiguration;

NS_ASSUME_NONNULL_BEGIN

OBJC_EXTERN NSString *const FMIStoreDidUpdateFromCloudNotification;
OBJC_EXTERN NSString *const FMIStoreWillChangeStoreNotification;
OBJC_EXTERN NSString *const FMIStoreDidChangeStoreNotification;

/**
 * The FMIStore class manages an application's core data stack.
 */
@interface FMIStore : NSObject

/**
 * The assigned store configuration.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) FMIStoreConfiguration *configuration;

/**
 * The managed object context.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSManagedObjectContext *managedObjectContext;

/**
 * The persistent store coordinator.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/**
 * The persistent store options.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSDictionary *persistentStoreOptions;

/**
 * A Boolean that indicates whether iCloud sync is enabled or not.
 */
@property (readonly, getter=isICloudEnabled, NS_NONATOMIC_IOSONLY) BOOL enableICloud;

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
 * Forces the store to use a SQLite store.
 *
 * @param configuration The stores configuration.
 */
- (void)useSQLiteStoreWithConfiguration:(FMIStoreConfiguration *)configuration;

/**
 * Forces the store to use an in memory store.
 *
 * @param configuration The stores configuration.
 */
- (void)useInMemoryStoreWithConfiguration:(FMIStoreConfiguration *)configuration;

/**
 * Migrates the iCloud store to the locale store.
 */
- (void)migrateICloudStoreToLocalStore;

/**
 * Migrates the locale store to an iCloud store.
 */
- (void)migrateLocalStoreToICloudStoreWithOldCloudStatus:(FMICloudStatus)oldCloudStatus;

/**
 * Resets the whole Core Data stack.
 */
- (void)resetCoreDataStack;

/**
 * Resets the iCloud store.
 */
- (BOOL)resetICloudStoreIfNeeded;

/**
 * Creates a new \c NSManagedObjectContext with the current \c persistentStoreCoordinator
 *
 * @return A new \c NSManagedObjectContext.
 */
- (NSManagedObjectContext *)createNewManagedObjectContext;

@end

NS_ASSUME_NONNULL_END
