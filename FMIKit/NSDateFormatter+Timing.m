//
//  NSDateFormatter+Timing.m
//
//  Created by Florian Mielke on 29.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSDateFormatter+Timing.h"


@implementation NSDateFormatter (Timing)


- (BOOL)is24HourStyle
{
    NSDateFormatterStyle currentTimeStyle = [self timeStyle];
    [self setTimeStyle:NSDateFormatterMediumStyle];
    BOOL is24HourStyle = ([[self dateFormat] hasSuffix:@"a"] == NO);
    [self setTimeStyle:currentTimeStyle];
    
    return is24HourStyle;
}


- (NSString *)calendarDateAndTimeFormat
{
    NSString *template = ([self is24HourStyle]) ? @"yyyyMMMdHHmmE" : @"yyyyMMMdhmmEa";
	return [NSDateFormatter dateFormatFromTemplate:template options:0 locale:[self locale]];
}


- (NSString *)calendarDateFormat
{
    NSString *template = ([self is24HourStyle]) ? @"yyyyMMMMdE" : @"yyyyMMMMdEa";
	return [NSDateFormatter dateFormatFromTemplate:template options:0 locale:[self locale]];
}


- (NSString *)iso8601DateFormat
{
    return @"yyyy-MM-dd'T'HH:mm";
}


@end
