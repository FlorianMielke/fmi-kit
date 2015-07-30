//
//  Created by Florian Mielke on 10.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSCalendar+Calculations.h"

@implementation NSCalendar (Calculations)

- (NSDate *)fm_dateForNextWeekOfDate:(NSDate *)date {
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.weekOfYear = 1;
    return [self dateByAddingComponents:dateComponents toDate:date options:0];
}

- (NSDate *)fm_endOfDayForDate:(NSDate *)date {
    NSDateComponents *dateComponents = [self components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    dateComponents.hour = 23;
    dateComponents.minute = 59;
    dateComponents.second = 59;
    return [self dateFromComponents:dateComponents];
}

- (NSDate *)fm_startOfDayForDate:(NSDate *)date {
    NSDateComponents *dateComponents = [self components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [self dateFromComponents:dateComponents];
}

- (NSDate *)fm_dateForYearAfterDate:(NSDate *)date {
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.year = 1;
    return [self dateByAddingComponents:dateComponents toDate:date options:0];
}

- (BOOL)fm_isDate:(NSDate *)date1 inSameDayAsDate:(NSDate *)date2 {
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *date1Components = [self components:unitFlags fromDate:date1];
    NSDateComponents *date2Components = [self components:unitFlags fromDate:date2];
    BOOL isEqualYear = (date1Components.year == date2Components.year);
    BOOL isEqualMonth = (date1Components.month == date2Components.month);
    BOOL isEqualDay = (date1Components.day == date2Components.day);
    return (isEqualYear && isEqualMonth && isEqualDay);
}

- (NSDate *)fm_dateWithoutSecondsForDate:(NSDate *)date {
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [self components:unitFlags fromDate:date];
    dateComponents.second = 0;
    return [self dateFromComponents:dateComponents];
}

- (NSDate *)fm_firstDayOfYearForDate:(NSDate *)date {
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [self components:unitFlags fromDate:date];
    dateComponents.month = 1;
    dateComponents.day = 1;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    return [self dateFromComponents:dateComponents];
}

- (NSDate *)fm_noonOfDayForDate:(NSDate *)date {
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [self components:unitFlags fromDate:date];
    dateComponents.hour = 12;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    return [self dateFromComponents:dateComponents];
}

- (NSDate *)fm_randomDateForYear:(NSInteger)year {
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = 1;
    dateComponents.day = 15;
    dateComponents.year = year;
    return [self dateFromComponents:dateComponents];
}

- (NSInteger)fm_weekdayForDate:(NSDate *)date {
    NSDateComponents *dateComponents = [self components:NSCalendarUnitWeekday fromDate:date];
    return dateComponents.weekday;
}

- (NSInteger)fm_yearForDate:(NSDate *)date {
    NSDateComponents *dateComponents = [self components:NSCalendarUnitYear fromDate:date];
    return dateComponents.year;
}

@end
