//
//  NSPersistentStoreCoordinator+Validation.h
//
//  Created by Florian Mielke on 7/8/11.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

#import <CoreData/CoreData.h>


/**
 * Adds methods to the NSPersistentStoreCoordinator class to enhance validations.
 */
@interface NSPersistentStoreCoordinator (Validation)

/**
 * Returns a Boolean value that indicates whether the persistent store at URL is compatible the given attribtues.
 * @param url        The file url to the persistent store to check.
 * @param type       The type of the store to validate.
 * @param entityName An entity name in the store to validate.
 * @return YES if the persistent store is valid, otherwise NO.
 */
+ (BOOL)isValidPersistentStoreAtURL:(NSURL *)url ofType:(NSString *)type containsEntityWithName:(NSString *)entityName;

@end
