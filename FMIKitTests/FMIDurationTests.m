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
    XCTAssertEqual([self.duration timeInterval], (NSTimeInterval)0);
}

- (void)testInitializeWithTimeIntervalOf1AssignesDuration {
    FMIDuration *duration = [[FMIDuration alloc] initWithTimeInterval:1];
    XCTAssertEqual([duration timeInterval], (NSTimeInterval)1);
}

- (void)testDurationInitializedViaFactoryMethodWithTimeIntervalOfZero {
    XCTAssertEqual([[FMIDuration zero] timeInterval], (NSTimeInterval)0);
}

- (void)testInitializeViaWithTimeIntervalOf1AssignesDuration {
    XCTAssertEqual([[FMIDuration durationWithTimeInterval:1] timeInterval], (NSTimeInterval)1);
}

- (void)test24HoursFactoryMethodShouldReturn86400Seconds {
    NSTimeInterval secondsFor24Hours = 86400;
    FMIDuration *duration = [FMIDuration durationWithTimeInterval:secondsFor24Hours];
    XCTAssertTrue([[FMIDuration twentyFourHours] compare:duration] == NSOrderedSame);
}

- (void)testDurationShouldBeEqualToSelf {
    XCTAssertTrue([self.duration isEqual:self.duration]);
}

- (void)testDurationShouldBeEqualToDurationWith0TimeInterval {
    XCTAssertTrue([self.duration isEqual:[FMIDuration zero]]);
}

- (void)testDurationShouldNotBeEqualToDurationWith1TimeInterval {
    FMIDuration *duration = [FMIDuration durationWithTimeInterval:1];
    XCTAssertFalse([self.duration isEqual:duration]);
}

- (void)testComparingDurations {
    FMIDuration *duration = [FMIDuration durationWithTimeInterval:1];
    FMIDuration *sameDuration = [FMIDuration durationWithTimeInterval:1];
    FMIDuration *biggerDuration = [FMIDuration durationWithTimeInterval:2];
    FMIDuration *smallerDuration = [FMIDuration durationWithTimeInterval:0];

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

- (void)testSecondsFraction {
    [self verifySecondsUnitOfDurationForTimeInterval:1 isSeconds:1];
    [self verifySecondsUnitOfDurationForTimeInterval:2 isSeconds:2];
    [self verifySecondsUnitOfDurationForTimeInterval:60 isSeconds:0];
    [self verifySecondsUnitOfDurationForTimeInterval:61 isSeconds:1];
    [self verifySecondsUnitOfDurationForTimeInterval:28861 isSeconds:1];
    [self verifySecondsUnitOfDurationForTimeInterval:-28861 isSeconds:1];
    [self verifySecondsUnitOfDurationForTimeInterval:28930 isSeconds:10];
    [self verifySecondsUnitOfDurationForTimeInterval:-28930 isSeconds:10];
}

- (void)testIsNegativeValidation {
    XCTAssertFalse([[FMIDuration durationWithTimeInterval:0] isNegative]);
    XCTAssertTrue([[FMIDuration durationWithTimeInterval:-1] isNegative]);
    XCTAssertFalse([[FMIDuration durationWithTimeInterval:1] isNegative]);
}

- (void)testDurationConformsToCopyingProtocol {
    XCTAssertTrue([self.duration conformsToProtocol:@protocol(NSCopying)]);
}

- (void)verifyHoursUnitOfDurationForTimeInterval:(NSTimeInterval)timeInterval isHours:(NSInteger)hours {
    FMIDuration *duration = [FMIDuration durationWithTimeInterval:timeInterval];
    XCTAssertEqual([duration hours], hours);
}

- (void)verifyMinutesUnitOfDurationForTimeInterval:(NSTimeInterval)timeInterval isMinutes:(NSInteger)minutes {
    FMIDuration *duration = [FMIDuration durationWithTimeInterval:timeInterval];
    XCTAssertEqual([duration minutes], minutes);
}

- (void)verifySecondsUnitOfDurationForTimeInterval:(NSTimeInterval)timeInterval isSeconds:(NSInteger)seconds {
    FMIDuration *duration = [FMIDuration durationWithTimeInterval:timeInterval];
    XCTAssertEqual([duration seconds], seconds);
}

- (void)testEncode {
    NSData *archivedObject = [NSKeyedArchiver archivedDataWithRootObject:self.duration];
    XCTAssertTrue(archivedObject.length > 0);
}

- (void)testDecode {
    NSData *archivedObject = [NSKeyedArchiver archivedDataWithRootObject:self.duration];
    FMIDuration *unarchivedObject = [NSKeyedUnarchiver unarchiveObjectWithData:archivedObject];
    XCTAssertEqualObjects(unarchivedObject, self.duration);
}

- (void)testCopying {
    FMIDuration *copy = [self.duration copy];

    XCTAssertNotEqual(self.duration, copy);
    XCTAssertEqualObjects(self.duration, copy);
}

@end
