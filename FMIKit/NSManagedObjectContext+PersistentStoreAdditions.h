//
//  NSManagedObjectContext+PersistentStoreAdditions.h
//
//  Created by Florian Mielke on 24.03.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <CoreData/CoreData.h>

/**
 * This category adds methods to NSManagedObjectContext to improve persistent store checks
 */
@interface NSManagedObjectContext (PersistentStoreAdditions)

/**
 * Checks whether the persistent store is emtpy.
 * @param entities A list of entities to check.
 * @return YES if no entities of given entities are found. Otherwise NO.
 */
- (BOOL)persistentStoreIsEmtpyForEntities:(NSArray *)entityNames;

@end
