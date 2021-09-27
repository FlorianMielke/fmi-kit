#import <XCTest/XCTest.h>
#import "FMIDateHelper.h"
#import "NSCalendar+SharedInstances.h"

@interface FMIDateHelperTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) NSDate *date;
@property (NS_NONATOMIC_IOSONLY) NSTimeZone *timeZone;

@end

@implementation FMIDateHelperTest

- (void)setUp {
    [super setUp];
    self.date = [NSDate dateWithTimeIntervalSinceReferenceDate:43200];
    self.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
}

- (void)testItTrimsTheSecondsOfADate {
    NSDateComponents *referenceDateComponents = [[NSCalendar currentCalendar] componentsInTimeZone:self.timeZone fromDate:self.date];

    NSDate *dateWithoutSeconds = [FMIDateHelper dateWithoutSecondsFromDate:self.date];

    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] componentsInTimeZone:self.timeZone fromDate:dateWithoutSeconds];
    XCTAssertEqual(0, dateComponents.nanosecond);
    XCTAssertEqual(0, dateComponents.second);
    XCTAssertEqual(referenceDateComponents.hour, dateComponents.hour);
    XCTAssertEqual(referenceDateComponents.minute, dateComponents.minute);
    XCTAssertEqual(referenceDateComponents.day, dateComponents.day);
    XCTAssertEqual(referenceDateComponents.month, dateComponents.month);
    XCTAssertEqual(referenceDateComponents.year, dateComponents.year);
}

- (void)testItCalculatesTheTimeByAddingOneMinuteAnOneSecond {
    NSDate *now = [NSDate date];
    NSDateComponents *nowDateComponents = [[NSCalendar currentCalendar] componentsInTimeZone:self.timeZone fromDate:now];

    NSDate *nextMinuteWithoutSeconds = [FMIDateHelper dateForNextMinuteAndOneSecond];

    NSDateComponents *nextMinuteDateComponents = [[NSCalendar currentCalendar] componentsInTimeZone:self.timeZone fromDate:nextMinuteWithoutSeconds];
    XCTAssertEqual(0, nextMinuteDateComponents.nanosecond);
    XCTAssertEqual(1, nextMinuteDateComponents.second);
    XCTAssertEqual(nowDateComponents.minute + 1, nextMinuteDateComponents.minute);
    XCTAssertEqual(nowDateComponents.hour, nextMinuteDateComponents.hour);
    XCTAssertEqual(nowDateComponents.day, nextMinuteDateComponents.day);
    XCTAssertEqual(nowDateComponents.month, nextMinuteDateComponents.month);
    XCTAssertEqual(nowDateComponents.year, nextMinuteDateComponents.year);
}

- (void)testItAddsHourAndMinuteToADateInTimeZone {
    NSTimeZone *berlinTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600];
    NSDate *noonWithFixedStartTime = [NSDate dateWithTimeIntervalSinceReferenceDate:120];
    
    NSDate *startTime = [FMIDateHelper dateBySettingHour:1 minute:2 ofDate:self.date inTimeZone:berlinTimeZone];
    
    XCTAssertEqualObjects(noonWithFixedStartTime, startTime);
}

- (void)testItCalculatesTheTimeIntervalFromADateToADate {
    NSDate *fromDate = [NSDate dateWithTimeIntervalSinceReferenceDate:120];
    NSDate *toDate = [NSDate dateWithTimeIntervalSinceReferenceDate:240];
    XCTAssertEqual(120, [FMIDateHelper timeIntervalFromDate:fromDate toDate:toDate]);
}

@end
