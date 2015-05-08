//
//  NSCalendar+Calculations.h
//
//  Created by Florian Mielek on 10.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;


/**
 * Adds calendrical calculation methods to NSCalendar.
 */
@interface NSCalendar (Calculations)

/**
 * Returns a new NSDate by adding one week to the given date.
 * @param date A date object.
 * @return A new NSDate one week after the given date.
 */
- (NSDate *)fm_dateForNextWeekOfDate:(NSDate *)date;

/**
 * Returns a new NSDate with the last moment date of a given date.
 * @param date A date object.
 * @return A new NSDate with the last moment date of a given date.
 */
- (NSDate *)fm_endOfDayForDate:(NSDate *)date;

/**
 * Returns a new NSDate with the first moment date of a given date.
 * @param date A date object.
 * @return A new NSDate with the first moment date of a given date.
 */
- (NSDate *)fm_startOfDayForDate:(NSDate *)date;

/**
 * Returns a new NSDate by adding one year to the given date.
 * @param date A date object.
 * @return A new NSDate one year after the given date.
 */
- (NSDate *)fm_dateForYearAfterDate:(NSDate *)date;

/**
 * Returns a Boolean that indicate whether date1 is in the same day as date2.
 * @param date1 A date object.
 * @param date2 A date object.
 * @return TRUE if date1 is in the same day as date2, otherwise NO.
 */
- (BOOL)fm_isDate:(NSDate *)date1 inSameDayAsDate:(NSDate *)date2;

/**
 * Returns a new NSDate object by resetting the given date's seconds.
 * @param date A date object.
 * @return A new NSDate without seconds.
 */
- (NSDate *)fm_dateWithoutSecondsForDate:(NSDate *)date;

/**
 * Returns the first day  of a given date.
 * @param date A date object.
 * @return The year of the given date.
 */
- (NSDate *)fm_firstDayOfYearForDate:(NSDate *)date;

/**
 * Returns the noon of date of a given date.
 * @param date A date object.
 * @return A new NSDate object with the noon of the given date.
 */
- (NSDate *)fm_noonOfDayForDate:(NSDate *)date;

/**
 * Returns a random date for a given year.
 * @param year A year.
 * @return A new NSDate object in the given year.
 */
- (NSDate *)fm_randomDateForYear:(NSInteger)year;

/**
 *	Returns the weekday (1-7) for a given date.
 *	@param	date	A date object.
 *	@return	The weekday of the given date.
 */
- (NSInteger)fm_weekdayForDate:(NSDate *)date;

/**
 * Returns the year of a given date.
 * @param date A date object.
 * @return The year of the given date.
 */
- (NSInteger)fm_yearForDate:(NSDate *)date;

@end
