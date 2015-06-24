//
//  NSCalendar_CalculationsTests.m
//
//  Created by Florian Mielke on 10.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "NSCalendar+Calculations.h"


@interface NSCalendar_CalculationsTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) NSCalendar *sut;
@property (NS_NONATOMIC_IOSONLY) NSDateFormatter *dateFormatter;
@property (NS_NONATOMIC_IOSONLY) unsigned unitFlags;

@end



@implementation NSCalendar_CalculationsTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    self.unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    self.sut = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [self.sut setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}


- (void)tearDown
{
    self.sut = nil;
    self.dateFormatter = nil;

    [super tearDown];
}



#pragma mark - Calculations

- (void)testNoonForDayOfDateReturnsAnHourOf12
{

    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    
    NSDate *noonOfDayForDate = [self.sut fm_noonOfDayForDate:date];
    
    NSDateComponents *noonOfDayDateComponents = [self.sut components:NSCalendarUnitHour fromDate:noonOfDayForDate];
    XCTAssertEqual([noonOfDayDateComponents hour], 12);
}


- (void)testCalendarShouldReturnDateOneYearAfterGivenDate
{

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    
    NSDate *newDate = [self.sut fm_dateForYearAfterDate:date];
    
    NSDateComponents *dateComponents = [self.sut components:self.unitFlags fromDate:date];
    NSDateComponents *newDateComponents = [self.sut components:self.unitFlags fromDate:newDate];
    
    XCTAssertEqual(([newDateComponents year] - 1), [dateComponents year]);
    XCTAssertEqual([newDateComponents month], [dateComponents month]);
    XCTAssertEqual([newDateComponents day], [dateComponents day]);
    XCTAssertEqual([newDateComponents hour], [dateComponents hour]);
    XCTAssertEqual([newDateComponents minute], [dateComponents minute]);
    XCTAssertEqual([newDateComponents second], [dateComponents second]);
}


- (void)testCalendarShouldReturnNilWhenRequestingOneYearAfterNilDate
{
    XCTAssertNil([self.sut fm_dateForYearAfterDate:nil]);
}


- (void)testCalendarShouldReturnTrueForTheSameDates
{

    NSDate *date = [self.dateFormatter dateFromString:@"2013-01-01 15:44:00"];
    
    XCTAssertTrue([self.sut fm_isDate:date inSameDayAsDate:date]);
}


- (void)testCalendarShouldReturnFalseForDifferentDates
{

    NSDate *date1 = [self.dateFormatter dateFromString:@"2013-01-01 15:44:00"];
    NSDate *date2 = [self.dateFormatter dateFromString:@"2013-02-01 16:44:00"];
    
    XCTAssertFalse([self.sut fm_isDate:date1 inSameDayAsDate:date2]);
}


- (void)testCalendarShouldReturnTrueForDifferentDatesOnSameDay
{

    NSDate *date1 = [self.dateFormatter dateFromString:@"2013-01-01 15:44:00"];
    NSDate *date2 = [self.dateFormatter dateFromString:@"2013-01-01 16:44:00"];
    
    XCTAssertTrue([self.sut fm_isDate:date1 inSameDayAsDate:date2]);
}


- (void)testCalendarShouldReturnTheStartOfAGivenDate
{

    NSDate *date = [self.dateFormatter dateFromString:@"2013-01-01 15:44:00"];
    
    NSDate *startOfDate = [self.sut fm_startOfDayForDate:date];
    
    NSDateComponents *dateComponents = [self.sut components:self.unitFlags fromDate:startOfDate];
    
    XCTAssertEqual([dateComponents year], 2013);
    XCTAssertEqual([dateComponents month], 1);
    XCTAssertEqual([dateComponents day], 1);
    XCTAssertEqual([dateComponents hour], 0);
    XCTAssertEqual([dateComponents minute], 0);
    XCTAssertEqual([dateComponents second], 0);
}


- (void)testCalendarShouldReturnTheEndOfAGivenDate
{

    NSDate *date = [self.dateFormatter dateFromString:@"2013-01-01 15:44:00"];
    
    NSDate *startOfDate = [self.sut fm_endOfDayForDate:date];
    
    NSDateComponents *dateComponents = [self.sut components:self.unitFlags fromDate:startOfDate];
    
    XCTAssertEqual([dateComponents year], 2013);
    XCTAssertEqual([dateComponents month], 1);
    XCTAssertEqual([dateComponents day], 1);
    XCTAssertEqual([dateComponents hour], 23);
    XCTAssertEqual([dateComponents minute], 59);
    XCTAssertEqual([dateComponents second], 59);
}




@end
