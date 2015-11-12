//
//  Created by Florian Mielke on 10.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSCalendar+Calculations.h"

@implementation NSCalendar (Calculations)

- (nullable NSDate *)fmi_dateForNextWeekOfDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.weekOfYear = 1;
    return [self dateByAddingComponents:dateComponents toDate:date options:0];
}

- (nullable NSDate *)fmi_startOfDayForDate:(NSDate *)date {
    return [self startOfDayForDate:date];
}

- (nullable NSDate *)fmi_endOfDayForDate:(NSDate *)date {
    NSDateComponents *dateComponents = [self components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    dateComponents.hour = 23;
    dateComponents.minute = 59;
    dateComponents.second = 59;
    return [self dateFromComponents:dateComponents];
}

- (nullable NSDate *)fmi_dateForYearAfterDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = 1;
    return [self dateByAddingComponents:dateComponents toDate:date options:0];
}

- (BOOL)fmi_isDate:(NSDate *)date1 inSameDayAsDate:(NSDate *)date2 {
    return [self isDate:date1 inSameDayAsDate:date2];
}

- (nullable NSDate *)fmi_dateWithoutSecondsForDate:(NSDate *)date {
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [self components:unitFlags fromDate:date];
    dateComponents.second = 0;
    return [self dateFromComponents:dateComponents];
}

- (nullable NSDate *)fmi_firstDayOfYearForDate:(NSDate *)date {
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [self components:unitFlags fromDate:date];
    dateComponents.month = 1;
    dateComponents.day = 1;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    return [self dateFromComponents:dateComponents];
}

- (nullable NSDate *)fmi_noonOfDayForDate:(NSDate *)date {
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [self components:unitFlags fromDate:date];
    dateComponents.hour = 12;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    return [self dateFromComponents:dateComponents];
}

- (nullable NSDate *)fmi_randomDateForYear:(NSInteger)year {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    dateComponents.day = 15;
    dateComponents.year = year;
    return [self dateFromComponents:dateComponents];
}

- (NSInteger)fmi_weekdayForDate:(NSDate *)date {
    NSDateComponents *dateComponents = [self components:NSCalendarUnitWeekday fromDate:date];
    return dateComponents.weekday;
}

- (NSInteger)fmi_yearForDate:(NSDate *)date {
    NSDateComponents *dateComponents = [self components:NSCalendarUnitYear fromDate:date];
    return dateComponents.year;
}

@end
