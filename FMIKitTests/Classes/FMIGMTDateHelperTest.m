#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMIGMTDateHelper.h"

@interface FMIGMTDateHelperTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) NSDate *date;
@property (NS_NONATOMIC_IOSONLY) NSTimeZone *timeZone;

@end

@implementation FMIGMTDateHelperTest

- (void)setUp {
    [super setUp];
    self.date = [NSDate dateWithTimeIntervalSinceReferenceDate:43200];
    self.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
}

- (void)testItComputesNoonOfToday {
    NSDateComponents *referenceDateComponents = [[NSCalendar currentCalendar] componentsInTimeZone:self.timeZone fromDate:self.date];

    NSDate *noonOfDate = [FMIGMTDateHelper dateForNoonOfDateInGMT:self.date];

    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] componentsInTimeZone:self.timeZone fromDate:noonOfDate];
    XCTAssertEqual(12, dateComponents.hour);
    XCTAssertEqual(0, dateComponents.minute);
    XCTAssertEqual(0, dateComponents.second);
    XCTAssertEqual(0, dateComponents.nanosecond);
    XCTAssertEqual(referenceDateComponents.year, dateComponents.year);
    XCTAssertEqual(referenceDateComponents.month, dateComponents.month);
    XCTAssertEqual(referenceDateComponents.day, dateComponents.day);
}

- (void)testItComputesTheNoonOfADateInTimeZone {
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:-36000];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = timeZone;
    NSCalendar *gmtCalendar = [NSCalendar currentCalendar];
    gmtCalendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDate *sampleDate = [calendar dateWithEra:1 year:2015 month:8 day:4 hour:23 minute:55 second:0 nanosecond:0];

    NSDate *noonDate = [FMIGMTDateHelper dateForNoonOfDayInGMTFromDate:sampleDate inTimeZone:timeZone];

    NSDateComponents *dateComponents = [gmtCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:noonDate];
    XCTAssertEqual(2015, dateComponents.year);
    XCTAssertEqual(8, dateComponents.month);
    XCTAssertEqual(4, dateComponents.day);
    XCTAssertEqual(12, dateComponents.hour);
    XCTAssertEqual(0, dateComponents.minute);
    XCTAssertEqual(0, dateComponents.second);
}

- (void)testItProvidesTheWeekdayForADate {
    NSInteger weekday = [FMIGMTDateHelper weekdayOfDateInGMT:[NSDate dateWithTimeIntervalSinceReferenceDate:60]];
    NSInteger monday = 2;
    XCTAssertEqual(monday, weekday);
}

- (void)testItProvidesTheWeekdayIndexForADate {
    NSInteger weekdayIndex = [FMIGMTDateHelper weekdayIndexOfDateInGMT:[NSDate dateWithTimeIntervalSinceReferenceDate:60]];
    NSInteger monday = 2;
    XCTAssertEqual((monday - 1), weekdayIndex);
}

- (void)testItProvidesTimeComponentsForADate {
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:3720];

    NSDateComponents *timeComponents = [FMIGMTDateHelper timeComponentsOfDateInGMT:date];

    XCTAssertEqual(1, timeComponents.hour);
    XCTAssertEqual(2, timeComponents.minute);
}

@end