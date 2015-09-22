#import <XCTest/XCTest.h>
#import "FMIDateHelper.h"

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
    XCTAssertEqual(0, dateComponents.second);
    XCTAssertEqual(0, dateComponents.nanosecond);
    XCTAssertEqual(referenceDateComponents.hour, dateComponents.hour);
    XCTAssertEqual(referenceDateComponents.minute, dateComponents.minute);
    XCTAssertEqual(referenceDateComponents.year, dateComponents.year);
    XCTAssertEqual(referenceDateComponents.month, dateComponents.month);
    XCTAssertEqual(referenceDateComponents.day, dateComponents.day);
}

- (void)testItAddsHourAndMinuteToADateInTimeZone {
    NSTimeZone *berlinTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:3600];
    NSDate *noonWithFixedStartTime = [NSDate dateWithTimeIntervalSinceReferenceDate:120];
    
    NSDate *startTime = [FMIDateHelper dateBySettingHour:1 minute:2 ofDate:self.date inTimeZone:berlinTimeZone];
    
    XCTAssertEqualObjects(noonWithFixedStartTime, startTime);
}

@end