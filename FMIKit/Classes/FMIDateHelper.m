#import "FMIDateHelper.h"
#import "NSCalendar+SharedInstances.h"

@implementation FMIDateHelper

+ (NSDate *)dateForNextMinuteWithoutSeconds {
    NSDate *nowWithoutSeconds = [FMIDateHelper dateForCurrentTimeWithoutSeconds];
    return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMinute value:1 toDate:nowWithoutSeconds options:0];
}

+ (NSDate *)dateForCurrentTimeWithoutSeconds {
    return [FMIDateHelper dateWithoutSecondsFromDate:[NSDate date]];
}

+ (NSDate *)dateWithoutSecondsFromDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSCalendar sharedCurrentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    dateComponents.second = 0;
    return [[NSCalendar sharedCurrentCalendar] dateFromComponents:dateComponents];
}

+ (NSDate *)dateBySettingHour:(NSInteger)hour minute:(NSInteger)minute ofDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone {
    NSTimeZone *previousTimeZone = [NSCalendar sharedCurrentCalendar].timeZone;
    [NSCalendar sharedCurrentCalendar].timeZone = timeZone;
    NSDate *newDate = [[NSCalendar sharedCurrentCalendar] dateBySettingHour:hour minute:minute second:0 ofDate:date options:0];
    [NSCalendar sharedCurrentCalendar].timeZone = previousTimeZone;
    return newDate;
}

+ (NSTimeInterval)timeIntervalFromDateToNow:(NSDate *)date {
    NSDate *now = [FMIDateHelper dateForCurrentTimeWithoutSeconds];
    return [FMIDateHelper timeIntervalFromDate:date toDate:now];
}

+ (NSTimeInterval)timeIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSDateComponents *components = [[NSCalendar sharedCurrentCalendar] components:NSCalendarUnitSecond fromDate:fromDate toDate:toDate options:0];
    return components.second;
}

@end
