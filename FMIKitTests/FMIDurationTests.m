//
//  Created by Florian Mielke on 09.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <FMIKit/FMIDuration.h>

@interface FMIDurationTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIDuration *duration;

@end

@implementation FMIDurationTests

- (void)setUp {
    [super setUp];

    self.duration = [FMIDuration new];
}

- (void)testDurationIsInitialized {
    XCTAssertNotNil(self.duration);
}

- (void)testDurationIsInitializedWithTimeIntervalOfZero {
    XCTAssertEqual(self.duration.seconds, 0);
}

- (void)testInitializeWithTimeIntervalOf1AssignesDuration {
    FMIDuration *duration = [[FMIDuration alloc] initWithSeconds:1];
    XCTAssertEqual(duration.seconds, 1);
}

- (void)testDurationInitializedViaFactoryMethodWithTimeIntervalOfZero {
    XCTAssertEqual(FMIDuration.zero.seconds, (NSTimeInterval)0);
}

- (void)testInitializeViaWithTimeIntervalOf1AssignesDuration {
    XCTAssertEqual([FMIDuration durationWithSeconds:1].seconds, 1);
}

- (void)test24HoursFactoryMethodShouldReturn86400Seconds {
    NSTimeInterval secondsFor24Hours = 86400;
    FMIDuration *duration = [FMIDuration durationWithSeconds:secondsFor24Hours];
    XCTAssertTrue([[FMIDuration twentyFourHours] compare:duration] == NSOrderedSame);
}

- (void)testDurationShouldBeEqualToSelf {
    XCTAssertEqual(self.duration, self.duration);
}

- (void)testDurationShouldBeEqualToDurationWith0TimeInterval {
    XCTAssertEqualObjects(self.duration, FMIDuration.zero);
}

- (void)testDurationShouldNotBeEqualToDurationWith1TimeInterval {
    FMIDuration *duration = [FMIDuration durationWithSeconds:1];
    XCTAssertNotEqualObjects(self.duration, duration);
}

- (void)testComparingDurations {
    FMIDuration *duration = [FMIDuration durationWithSeconds:1];
    FMIDuration *sameDuration = [FMIDuration durationWithSeconds:1];
    FMIDuration *biggerDuration = [FMIDuration durationWithSeconds:2];
    FMIDuration *smallerDuration = [FMIDuration durationWithSeconds:0];

    XCTAssertEqual([duration compare:sameDuration], NSOrderedSame);
    XCTAssertEqual([duration compare:smallerDuration], NSOrderedDescending);
    XCTAssertEqual([duration compare:biggerDuration], NSOrderedAscending);
}

- (void)testHoursFraction {
    [self verifyHoursUnitOfDurationForTimeInterval:1 isHours:0];
    [self verifyHoursUnitOfDurationForTimeInterval:28800 isHours:8];
    [self verifyHoursUnitOfDurationForTimeInterval:-28800 isHours:8];
    [self verifyHoursUnitOfDurationForTimeInterval:30600 isHours:8];
    [self verifyHoursUnitOfDurationForTimeInterval:-30600 isHours:8];
}

- (void)testMinutesFraction {
    [self verifyMinutesUnitOfDurationForTimeInterval:1 isMinutes:0];
    [self verifyMinutesUnitOfDurationForTimeInterval:28800 isMinutes:0];
    [self verifyMinutesUnitOfDurationForTimeInterval:-28800 isMinutes:0];
    [self verifyMinutesUnitOfDurationForTimeInterval:30600 isMinutes:30];
    [self verifyMinutesUnitOfDurationForTimeInterval:-30600 isMinutes:30];
}

- (void)testIsNegativeValidation {
    XCTAssertFalse([[FMIDuration durationWithSeconds:0] isNegative]);
    XCTAssertTrue([[FMIDuration durationWithSeconds:-1] isNegative]);
    XCTAssertFalse([[FMIDuration durationWithSeconds:1] isNegative]);
}

- (void)testDurationConformsToCopyingProtocol {
    XCTAssertTrue([self.duration conformsToProtocol:@protocol(NSCopying)]);
}

- (void)verifyHoursUnitOfDurationForTimeInterval:(NSTimeInterval)timeInterval isHours:(NSInteger)hours {
    FMIDuration *duration = [FMIDuration durationWithSeconds:timeInterval];
    XCTAssertEqual([duration hours], hours);
}

- (void)verifyMinutesUnitOfDurationForTimeInterval:(NSTimeInterval)timeInterval isMinutes:(NSInteger)minutes {
    FMIDuration *duration = [FMIDuration durationWithSeconds:timeInterval];
    XCTAssertEqual([duration minutes], minutes);
}

- (void)testCopying {
    FMIDuration *copy = [self.duration copy];

    XCTAssertNotEqual(self.duration, copy);
    XCTAssertEqualObjects(self.duration, copy);
}

@end
