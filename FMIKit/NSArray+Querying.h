//
//  NSArray+Querying.h
//
//  Created by Florian Mielke on 03.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;


/**
 * This category adds additional querying methods to the NSArray class.
 */
@interface NSArray (Querying)

/**
 * Returns a Boolean value that indicates whether a given string is present in the array.
 * @param aString A string object.
 * @return YES if aString is present in the array, otherwise NO.
 */
- (BOOL)containsString:(NSString *)aString;

/**
 * Returns a Boolean value that indicates whether the array has any objects.
 * @return YES if the array contains objects, otherwise NO.
 */
- (BOOL)fm_isEmpty;

/**
 * Returns a Boolean value that indicates whether a given index is in bounds of the array.
 * @param index An index.
 * @return YES if index is in bounds of the array, otherwise NO.
 */
- (BOOL)fm_isIndexInBoundsOfArray:(NSUInteger)index;

@end
