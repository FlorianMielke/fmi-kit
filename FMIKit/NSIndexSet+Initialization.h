//
//  NSIndexSet+Initialization.h
//
//  Created by Florian Mielke on 16.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;


/**
 * Adds initialization methods to NSIndexSet.
 */
@interface NSIndexSet (Initialization)

/**
 * Creates and returns an index set containing indexes from a given array (objects have to be with type NSNumber).
 * @param An array.
 */
+ (NSIndexSet *)indexSetWithArray:(NSArray *)anArray;

@end
