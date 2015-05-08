//
//  NSString+CSV.h
//
//  Created by Florian Mielke on 14.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;


/**
 * This category adds methods to NSString to improve CSV operations.
 */
@interface NSString (CSV)

/**
 * Returns a new string by enclosing the receiver with a given string.
 * @param encloser The encloser string.
 * @return NSString A new string by enclosing the receiver with the encloser.
 */
- (NSString *)stringByEnclosingWithString:(NSString *)encloser;

/**
 * Returns an array containing substrings from the receiver that have been divided by a given encloser and delimiter.
 * @param delimiter The delimiter string.
 * @param encloser The encloser string.
 * @return An NSArray object containing substrings from the receiver that have been divided by encloser and delimiter.
 */
- (NSArray *)componentsSeparatedByDelimiter:(NSString *)delimiter encloser:(NSString *)encloser;

@end
