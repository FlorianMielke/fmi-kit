#import "FMIGMTDateHelper.h"
#import "NSCalendar+SharedInstances.h"

@implementation FMIGMTDateHelper

+ (NSDate *)dateForNoonOfTodayInGMT {
    return [self dateForNoonOfDateInGMT:[NSDate date]];
}

+ (NSDate *)dateForNoonOfDateInGMT:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSCalendar sharedGMTCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    dateComponents.hour = 12;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    return [[NSCalendar sharedGMTCalendar] dateFromComponents:dateComponents];
}

+ (NSDate *)dateForNoonOfDayInGMTFromDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone {
    NSDateComponents *dayComponents = [[NSCalendar sharedGMTCalendar] componentsInTimeZone:timeZone fromDate:date];
    NSDateComponents *noonOfDateComponents = [[NSDateComponents alloc] init];
    noonOfDateComponents.year = dayComponents.year;
    noonOfDateComponents.month = dayComponents.month;
    noonOfDateComponents.day = dayComponents.day;
    noonOfDateComponents.hour = 12;
    noonOfDateComponents.minute = 0;
    noonOfDateComponents.second = 0;
    return [[NSCalendar sharedGMTCalendar] dateFromComponents:noonOfDateComponents];
}

+ (NSInteger)weekdayOfDateInGMT:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSCalendar sharedGMTCalendar] components:NSCalendarUnitWeekday fromDate:date];
    return dateComponents.weekday;
}

+ (NSUInteger)weekdayIndexOfDateInGMT:(NSDate *)date {
    return (NSUInteger) (([self weekdayOfDateInGMT:date] - 1));
}

+ (NSDateComponents *)timeComponentsOfDateInGMT:(NSDate *)date {
    return [[NSCalendar sharedGMTCalendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
}

@end