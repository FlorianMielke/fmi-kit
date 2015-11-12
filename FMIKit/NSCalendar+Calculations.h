//
//  Created by Florian Mielke on 10.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Adds calculation methods to NSCalendar.
 */
@interface NSCalendar (Calculations)

/**
 * Returns a new NSDate by adding one week to the given date.
 * @param date A date object.
 * @return A new NSDate one week after the given date.
 */
- (nullable NSDate *)fmi_dateForNextWeekOfDate:(NSDate *)date;

/**
 * Returns a new NSDate with the first moment date of a given date.
 * @param date A date object.
 * @return A new NSDate with the first moment date of a given date.
 */
- (nullable NSDate *)fmi_startOfDayForDate:(NSDate *)date;

/**
 * Returns a new NSDate with the last moment date of a given date.
 * @param date A date object.
 * @return A new NSDate with the last moment date of a given date.
 */
- (nullable NSDate *)fmi_endOfDayForDate:(NSDate *)date;

/**
 * Returns a new NSDate by adding one year to the given date.
 * @param date A date object.
 * @return A new NSDate one year after the given date.
 */
- (nullable NSDate *)fmi_dateForYearAfterDate:(NSDate *)date;

/**
 * Returns a Boolean that indicate whether date1 is in the same day as date2.
 * @param date1 A date object.
 * @param date2 A date object.
 * @return TRUE if date1 is in the same day as date2, otherwise NO.
 */
- (BOOL)fmi_isDate:(NSDate *)date1 inSameDayAsDate:(NSDate *)date2;

/**
 * Returns a new NSDate object by resetting the given date's seconds.
 * @param date A date object.
 * @return A new NSDate without seconds.
 */
- (nullable NSDate *)fmi_dateWithoutSecondsForDate:(NSDate *)date;

/**
 * Returns the first day  of a given date.
 * @param date A date object.
 * @return The year of the given date.
 */
- (nullable NSDate *)fmi_firstDayOfYearForDate:(NSDate *)date;

/**
 * Returns the noon of date of a given date.
 * @param date A date object.
 * @return A new NSDate object with the noon of the given date.
 */
- (nullable NSDate *)fmi_noonOfDayForDate:(NSDate *)date;

/**
 * Returns a random date for a given year.
 * @param year A year.
 * @return A new NSDate object in the given year.
 */
- (nullable NSDate *)fmi_randomDateForYear:(NSInteger)year;

/**
 *	Returns the weekday (1-7) for a given date.
 *	@param	date	A date object.
 *	@return	The weekday of the given date.
 */
- (NSInteger)fmi_weekdayForDate:(NSDate *)date;

/**
 * Returns the year of a given date.
 * @param date A date object.
 * @return The year of the given date.
 */
- (NSInteger)fmi_yearForDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END