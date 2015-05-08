//
//  NSNumberFormatter+Editing.h
//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;

/**
 *	Adds methods to NSNumberFormatter to enhance conversion of textual representations.
 */
@interface NSNumberFormatter (Editing)

/**
 *	Returns a string containing the textual representation of the provided number object.
 *	@param	number	An NSNumber object for which to return an editing string.
 *	@return	An NSString object that is used for editing the textual representation of number.
 */
- (NSString *)fm_editingStringFromNumber:(NSNumber *)number;

/**
 *	Returns an NSNumber object created by parsing a given editing string.
 *	@param	editingString	An NSString object that is parsed to generate the returned number object.
 *	@return	An NSNumber object created by parsing editing string using the receiver’s format.
 */
- (NSNumber *)fm_numberFromEditingString:(NSString *)editingString;

@end
