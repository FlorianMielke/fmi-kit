#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMIGMTDateHelper.h"

@interface FMIGMTDateHelperTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIGMTDateHelper *subject;
@property (NS_NONATOMIC_IOSONLY) NSDate *date;
@property (NS_NONATOMIC_IOSONLY) NSTimeZone *timeZone;

@end

@implementation FMIGMTDateHelperTest

- (void)setUp {
    [super setUp];
    self.date = [NSDate dateWithTimeIntervalSinceReferenceDate:43200];
    self.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    self.subject = [[FMIGMTDateHelper alloc] init];
}

- (void)testGMTCalendar_hasGMTTimeZone {
    XCTAssertEqual(0, self.subject.gmtCalendar.timeZone.secondsFromGMT);
}

- (void)testItComputesNoonOfToday {
    NSDateComponents *referenceDateComponents = [[NSCalendar currentCalendar] componentsInTimeZone:self.timeZone fromDate:self.date];

    NSDate *noonOfDate = [self.subject dateForNoonOfDateInGMT:self.date];

    NSDateComponents *dateComponents = [self.subject.gmtCalendar componentsInTimeZone:self.timeZone fromDate:noonOfDate];
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

    NSDate *noonDate = [self.subject dateForNoonOfDayInGMTFromDate:sampleDate inTimeZone:timeZone];

    NSDateComponents *dateComponents = [gmtCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:noonDate];
    XCTAssertEqual(2015, dateComponents.year);
    XCTAssertEqual(8, dateComponents.month);
    XCTAssertEqual(4, dateComponents.day);
    XCTAssertEqual(12, dateComponents.hour);
    XCTAssertEqual(0, dateComponents.minute);
    XCTAssertEqual(0, dateComponents.second);
}

- (void)testItTrimsTheSecondsOfADate {
    NSDateComponents *referenceDateComponents = [[NSCalendar currentCalendar] componentsInTimeZone:self.timeZone fromDate:self.date];

    NSDate *dateWithoutSeconds = [self.subject dateWithoutSecondsFromDate:self.date];

    NSDateComponents *dateComponents = [self.subject.gmtCalendar componentsInTimeZone:self.timeZone fromDate:dateWithoutSeconds];
    XCTAssertEqual(0, dateComponents.second);
    XCTAssertEqual(0, dateComponents.nanosecond);
    XCTAssertEqual(referenceDateComponents.hour, dateComponents.hour);
    XCTAssertEqual(referenceDateComponents.minute, dateComponents.minute);
    XCTAssertEqual(referenceDateComponents.year, dateComponents.year);
    XCTAssertEqual(referenceDateComponents.month, dateComponents.month);
    XCTAssertEqual(referenceDateComponents.day, dateComponents.day);
}

- (void)testItProvidesNameOfTheDefaultTimeZone {
    id mockTimeZone = OCMClassMock([NSTimeZone class]);
    OCMStub([mockTimeZone defaultTimeZone]).andReturn(mockTimeZone);
    OCMStub([mockTimeZone name]).andReturn(@"TimeZoneName");

    NSString *timeZoneName = [self.subject nameOfDefaultTimeZone];

    XCTAssertEqualObjects(@"TimeZoneName", timeZoneName);
    [mockTimeZone stopMocking];
}

- (void)testItProvidesTheWeekdayForADate {
    NSInteger weekday = [self.subject weekdayOfDateInGMT:[NSDate dateWithTimeIntervalSinceReferenceDate:60]];
    NSInteger monday = 2;
    XCTAssertEqual(monday, weekday);
}

- (void)testItProvidesTheWeekdayIndexForADate {
    NSInteger weekdayIndex = [self.subject weekdayIndexOfDateInGMT:[NSDate dateWithTimeIntervalSinceReferenceDate:60]];
    NSInteger monday = 2;
    XCTAssertEqual((monday - 1), weekdayIndex);
}

- (void)testItProvidesTimeComponentsForADate {
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:3720];

    NSDateComponents *timeComponents = [self.subject timeComponentsOfDateInGMT:date];

    XCTAssertEqual(1, timeComponents.hour);
    XCTAssertEqual(2, timeComponents.minute);
}

- (void)testItAddsHourAndMinuteToADateInTimeZone {
    NSTimeZone *berlinTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600];
    NSDate *noonWithFixedStartTime = [NSDate dateWithTimeIntervalSinceReferenceDate:120];

    NSDate *startTime = [self.subject dateBySettingHour:1 minute:2 ofDate:self.date inTimeZone:berlinTimeZone];

    XCTAssertEqualObjects(noonWithFixedStartTime, startTime);
}

@end