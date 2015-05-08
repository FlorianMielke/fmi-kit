//
//  NSCalendar+SharedInstancesTests.m
//
//  Created by Florian Mielke on 29.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "NSCalendar+SharedInstances.h"


@interface NSCalendar_SharedInstancesTests : XCTestCase

@end


@implementation NSCalendar_SharedInstancesTests



#pragma mark - Shared current calendar

- (void)testSharedCurrentCalendarShouldBeInitialized
{
    XCTAssertNotNil([NSCalendar sharedCurrentCalendar]);
}


- (void)testSharedCurrentCalendarShouldBeASingleton
{
    XCTAssertEqual([NSCalendar sharedCurrentCalendar], [NSCalendar sharedCurrentCalendar]);
}


- (void)testSharedCurrentCalendarShouldHaveTheCurrentCalendarsTimeZone
{
    NSTimeZone *sharedCalendarTimeZone = [[NSCalendar sharedCurrentCalendar] timeZone];
    NSTimeZone *currentCalendarTimeZone = [[NSCalendar currentCalendar] timeZone];
    
    XCTAssertTrue([sharedCalendarTimeZone isEqualToTimeZone:currentCalendarTimeZone]);
}


- (void)testSharedCurrentCalendarShouldHaveTheCurrentCalendarsFirstWeekday
{
    XCTAssertEqual([[NSCalendar sharedCurrentCalendar] firstWeekday], [[NSCalendar currentCalendar] firstWeekday]);
}


- (void)testSharedCurrentCalendarShouldHaveTheCurrentCalendarsLocale
{
    NSLocale *sharedCalendarLocal = [[NSCalendar sharedCurrentCalendar] locale];
    NSLocale *currentCalendarLocal = [[NSCalendar currentCalendar] locale];
    
    XCTAssertEqualObjects([sharedCalendarLocal localeIdentifier], [currentCalendarLocal localeIdentifier]);
}



#pragma mark - Shared GMT calendar

- (void)testSharedGMTCalendarShouldBeInitialized
{
    XCTAssertNotNil([NSCalendar sharedGMTCalendar]);
}


- (void)testSharedGMTCalendarShouldBeASingleton
{
    XCTAssertEqual([NSCalendar sharedGMTCalendar], [NSCalendar sharedGMTCalendar]);
}


- (void)testSharedCurrentCalendarShouldHaveGMTTimeZone
{
    NSTimeZone *sharedGMTCalendarTimeZone = [[NSCalendar sharedGMTCalendar] timeZone];
    NSTimeZone *gmtTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];

    XCTAssertTrue([sharedGMTCalendarTimeZone isEqualToTimeZone:gmtTimeZone]);
}



@end
