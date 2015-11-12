//
//  Created by Florian Mielke on 10.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSCalendar+Calculations.h"

@interface NSCalendar_CalculationsTests : XCTestCase

@property(NS_NONATOMIC_IOSONLY) NSCalendar *subject;
@property(NS_NONATOMIC_IOSONLY) NSDateFormatter *dateFormatter;
@property(NS_NONATOMIC_IOSONLY) unsigned unitFlags;

@end

@implementation NSCalendar_CalculationsTests

- (void)setUp {
    [super setUp];
    self.unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    self.subject = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.subject.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
}

- (void)testItCalculatesNoonForDayOfGivenDate {
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:0];

    NSDate *noonOfDayForDate = [self.subject fmi_noonOfDayForDate:date];

    NSDateComponents *noonOfDayDateComponents = [self.subject components:NSCalendarUnitHour fromDate:noonOfDayForDate];
    XCTAssertEqual(12, noonOfDayDateComponents.hour);
}

- (void)testItCalculatesTheDateOneYearAfterGivenDate {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *newDate = [self.subject fmi_dateForYearAfterDate:date];

    NSDateComponents *dateComponents = [self.subject components:self.unitFlags fromDate:date];
    NSDateComponents *newDateComponents = [self.subject components:self.unitFlags fromDate:newDate];

    XCTAssertEqual((newDateComponents.year - 1), dateComponents.year);
    XCTAssertEqual(newDateComponents.month, dateComponents.month);
    XCTAssertEqual(newDateComponents.day, dateComponents.day);
    XCTAssertEqual(newDateComponents.hour, dateComponents.hour);
    XCTAssertEqual(newDateComponents.minute, dateComponents.minute);
    XCTAssertEqual(newDateComponents.second, dateComponents.second);
}

- (void)testItReturnsTrueForTheSameDates {
    NSDate *date = [self.dateFormatter dateFromString:@"2013-01-01 15:44:00"];

    XCTAssertTrue([self.subject fmi_isDate:date inSameDayAsDate:date]);
}

- (void)testItReturnsFalseForDifferentDates {
    NSDate *date1 = [self.dateFormatter dateFromString:@"2013-01-01 15:44:00"];
    NSDate *date2 = [self.dateFormatter dateFromString:@"2013-02-01 16:44:00"];

    XCTAssertFalse([self.subject fmi_isDate:date1 inSameDayAsDate:date2]);
}

- (void)testItReturnsTrueForDifferentDatesOnSameDay {
    NSDate *date1 = [self.dateFormatter dateFromString:@"2013-01-01 15:44:00"];
    NSDate *date2 = [self.dateFormatter dateFromString:@"2013-01-01 16:44:00"];

    XCTAssertTrue([self.subject fmi_isDate:date1 inSameDayAsDate:date2]);
}

- (void)testICalculatesTheStartOfAGivenDate {
    NSDate *date = [self.dateFormatter dateFromString:@"2013-01-01 15:44:00"];
    NSDate *startOfDate = [self.subject fmi_startOfDayForDate:date];

    NSDateComponents *dateComponents = [self.subject components:self.unitFlags fromDate:startOfDate];

    XCTAssertEqual(dateComponents.year, 2013);
    XCTAssertEqual(dateComponents.month, 1);
    XCTAssertEqual(dateComponents.day, 1);
    XCTAssertEqual(dateComponents.hour, 0);
    XCTAssertEqual(dateComponents.minute, 0);
    XCTAssertEqual(dateComponents.second, 0);
}

- (void)testItCalculatesTheEndOfAGivenDate {
    NSDate *date = [self.dateFormatter dateFromString:@"2013-01-01 15:44:00"];
    NSDate *startOfDate = [self.subject fmi_endOfDayForDate:date];

    NSDateComponents *dateComponents = [self.subject components:self.unitFlags fromDate:startOfDate];

    XCTAssertEqual(dateComponents.year, 2013);
    XCTAssertEqual(dateComponents.month, 1);
    XCTAssertEqual(dateComponents.day, 1);
    XCTAssertEqual(dateComponents.hour, 23);
    XCTAssertEqual(dateComponents.minute, 59);
    XCTAssertEqual(dateComponents.second, 59);
}

@end
