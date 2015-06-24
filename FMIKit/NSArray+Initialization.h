//
//  NSArray+Initialization.h
//
//  Created by Florian Mielke on 15.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Adds initialization methods to NSArray.
 */
@interface NSArray (Initialization)

/**
 * Creates and returns an array containing indexes (as NSNumber) of an NSIndexSet.
 * @param indexes An index set.
 */
+ (NSArray *)arrayWithIndexes:(NSIndexSet *)indexes;

@end
