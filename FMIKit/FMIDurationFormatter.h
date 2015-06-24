//
//  FMIDurationFormatter.h
//
//  Created by Florian Mielke on 09.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;

@class FMIDuration;


typedef NS_ENUM(NSInteger, FMIDurationFormatterStyle) {
    FMIDurationFormatterStyleTime = 0,
    FMIDurationFormatterStyleDecimal = 1,
	FMIDurationFormatterStyleTimeLeadingZero = 2,
	FMIDurationFormatterStyleDecimalWithSymbol = 3,
};


/**
 *	Instances of FMIDurationFormatter create string representations of FMIDuration objects, and convert textual representations of durations into FMIDuration objects.
 */
@interface FMIDurationFormatter : NSFormatter

/**
 *	The duration style of the receiver.
 */
@property (NS_NONATOMIC_IOSONLY) FMIDurationFormatterStyle style;

/**
 *	The locale for the receiver.
 */
@property (NS_NONATOMIC_IOSONLY) NSLocale *locale;

/**
 *	Returns a string representation of a given duration used for editing.
 *	@param	duration    The duration to return an editing string for.
 *	@return	A string representation of duration that is used for editing.
 */
- (NSString *)editingStringFromDuration:(FMIDuration *)duration;

/**
 *	Returns a string representation of a given duration formatted using the receiver’s current settings.
 *	@param	duration    The duration to format.
 *	@return	A string representation of duration formatted using the receiver’s current settings.
 */
- (NSString *)stringFromDuration:(FMIDuration *)duration;

/**
 *	Returns a duration representation of a given string interpreted using the receiver’s current settings.
 *	@param	string  The string to parse.
 *	@return	A duration representation of string interpreted using the receiver’s current settings.
 */
- (FMIDuration *)durationFromString:(NSString *)string;

@end
