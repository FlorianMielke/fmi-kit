//
//  NSIndexSet+Initialization.h
//
//  Created by Florian Mielke on 16.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Adds initialization methods to NSIndexSet.
 */
@interface NSIndexSet (Initialization)

/**
 * Creates and returns an index set containing indexes from a given array (objects have to be with type NSNumber).
 * @param anArray The given array.
 */
+ (NSIndexSet *)indexSetWithArray:(NSArray *)anArray;

@end