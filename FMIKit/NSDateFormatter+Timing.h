//
//  NSDateFormatter+Timing.h
//
//  Created by Florian Mielke on 29.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;

 /**
 *	Adds timing methods to NSDateFormatter.
 */
@interface NSDateFormatter (Timing)

/**
 *	Determines whether the user's time is set to be 24 style or not.
 *	@return	YES if 24 hour style enabled, otherwise NO.
 */
- (BOOL)is24HourStyle;

/**
 *	Returns a date and time format like in the iOS calendar app.
 *	@return	NSString A date and time format string.
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *calendarDateAndTimeFormat;

/**
 *	Returns a date format like in the iOS calendar app.
 *	@return	NSString A date format string.
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *calendarDateFormat;

/**
 * Retuns a date format compatible to ISO 8601 format
 * @return NSString A date format string.
 */
- (NSString *)iso8601DateFormat;

@end
