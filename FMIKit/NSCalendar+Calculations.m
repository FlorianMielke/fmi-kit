//
//  NSCalendar+Calculations.m
//
//  Created by Florian Mielke on 10.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSCalendar+Calculations.h"


@implementation NSCalendar (Calculations)


- (NSDate *)fm_dateForNextWeekOfDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setWeekOfYear:1];
    
    return [self dateByAddingComponents:dateComponents toDate:date options:0];
}


- (NSDate *)fm_endOfDayForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    NSDateComponents *dateComponents = [self components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    [dateComponents setHour:23];
    [dateComponents setMinute:59];
    [dateComponents setSecond:59];
    
    return [self dateFromComponents:dateComponents];
}


- (NSDate *)fm_startOfDayForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    NSDateComponents *dateComponents = [self components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [self dateFromComponents:dateComponents];
}


- (NSDate *)fm_dateForYearAfterDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:1];
    
    return [self dateByAddingComponents:dateComponents toDate:date options:0];
}


- (BOOL)fm_isDate:(NSDate *)date1 inSameDayAsDate:(NSDate *)date2
{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *date1Components = [self components:unitFlags fromDate:date1];
    NSDateComponents *date2Components = [self components:unitFlags fromDate:date2];

    BOOL isEqualYear = ([date1Components year] == [date2Components year]);
    BOOL isEqualMonth = ([date1Components month] == [date2Components month]);
    BOOL isEqualDay = ([date1Components day] == [date2Components day]);
    
    return (isEqualYear && isEqualMonth && isEqualDay);
}


- (NSDate *)fm_dateWithoutSecondsForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [self components:unitFlags fromDate:date];
	[dateComponents setSecond:0];
	
	return [self dateFromComponents:dateComponents];
}


- (NSDate *)fm_firstDayOfYearForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [self components:unitFlags fromDate:date];
    [dateComponents setMonth:1];
    [dateComponents setDay:1];
    [dateComponents setHour:0];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    
    return [self dateFromComponents:dateComponents];
}


- (NSDate *)fm_noonOfDayForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [self components:unitFlags fromDate:date];
    [dateComponents setHour:12];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    
    return [self dateFromComponents:dateComponents];
}


- (NSDate *)fm_randomDateForYear:(NSInteger)year
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    [dateComponents setDay:15];
    [dateComponents setYear:year];
    
    return [self dateFromComponents:dateComponents];
}


- (NSInteger)fm_weekdayForDate:(NSDate *)date
{
    if (!date) {
        return NSNotFound;
    }
    
    NSDateComponents *dateComponents = [self components:NSCalendarUnitWeekday fromDate:date];
    return [dateComponents weekday];
}


- (NSInteger)fm_yearForDate:(NSDate *)date
{
    if (!date) {
        return NSNotFound;
    }
    
    NSDateComponents *dateComponents = [self components:NSCalendarUnitYear fromDate:date];
    return [dateComponents year];
}


@end
