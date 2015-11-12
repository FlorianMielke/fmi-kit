//
//  NSManagedObjectContext+PersistentStoreAdditions.m
//
//  Created by Florian Mielke on 24.03.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSManagedObjectContext+PersistentStoreAdditions.h"


@implementation NSManagedObjectContext (PersistentStoreAdditions)


- (BOOL)persistentStoreIsEmtpyForEntities:(NSArray *)entityNames
{
    if (!entityNames || [entityNames count] == 0) {
        return YES;
    }
    
    BOOL isEmtpy = YES;

    // Check for valid entities
    NSManagedObjectModel *managedObjectModel = [[self persistentStoreCoordinator] managedObjectModel];
    NSArray *entitiesByName = [[managedObjectModel entitiesByName] allKeys];
    
    for (NSString *entityName in entityNames)
    {
        if ([entitiesByName containsObject:entityName])
        {
            NSFetchRequest *fetchEntity = [NSFetchRequest fetchRequestWithEntityName:entityName];
            [fetchEntity setResultType:NSManagedObjectIDResultType];
            [fetchEntity setFetchLimit:1];
            
            if ([self countForFetchRequest:fetchEntity error:NULL] != 0)
            {
                isEmtpy = NO;
                break;
            }
        }
    }

    return isEmtpy;
}


@end
