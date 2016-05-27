#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMIReviewNotificationCoordinator.h"

@interface FMIReviewNotificationCoordinatorTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIReviewNotificationCoordinator *subject;
@property (NS_NONATOMIC_IOSONLY) id userDefaults;
@property (NS_NONATOMIC_IOSONLY) NSCalendar *calendar;

@end

@implementation FMIReviewNotificationCoordinatorTest

- (void)setUp {
    [super setUp];
    self.userDefaults = OCMClassMock([NSUserDefaults class]);
    self.calendar = [NSCalendar currentCalendar];
    self.subject = [[FMIReviewNotificationCoordinator alloc] initWithAppStoreID:@"::app-store-id::" userDefaults:self.userDefaults calendar:self.calendar];
}

- (void)testItReturnsTrueIfTheUserHasNotReviewedOrDeclined {
    OCMStub([self.userDefaults objectForKey:@"FMIReviewNotificationDateOfLastReviewKey"]).andReturn(nil);
    OCMStub([self.userDefaults objectForKey:@"FMIReviewNotificationHasDeclinedKey"]).andReturn(nil);

    BOOL shouldShow = self.subject.shouldShow;

    XCTAssertTrue(shouldShow);
}

- (void)testItReturnsTrueIfTheLastReviewIsOlderThan6Months {
    OCMStub([self.userDefaults objectForKey:@"FMIReviewNotificationHasDeclinedKey"]).andReturn(nil);
    NSDate *dateOfReview = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:-4 toDate:[NSDate date] options:0];
    OCMStub([self.userDefaults objectForKey:@"FMIReviewNotificationDateOfLastReviewKey"]).andReturn(dateOfReview);

    BOOL shouldShow = self.subject.shouldShow;

    XCTAssertTrue(shouldShow);
}

- (void)testItReturnsFalseIfTheUserHasDeclinedToReview {
    OCMStub([self.userDefaults objectForKey:@"FMIReviewNotificationHasDeclinedKey"]).andReturn(@YES);

    BOOL shouldShow = self.subject.shouldShow;

    XCTAssertFalse(shouldShow);
}

- (void)testItReturnsFalseIfTheLastReviewIsYoungerThan6Months {
    OCMStub([self.userDefaults objectForKey:@"FMIReviewNotificationHasDeclinedKey"]).andReturn(nil);
    NSDate *dateOfReview = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:-2 toDate:[NSDate date] options:0];
    OCMStub([self.userDefaults objectForKey:@"FMIReviewNotificationDateOfLastReviewKey"]).andReturn(dateOfReview);

    BOOL shouldShow = self.subject.shouldShow;

    XCTAssertFalse(shouldShow);
}

- (void)testItShouldSaveWhenTheUserHasDeclined {
    [self.userDefaults setExpectationOrderMatters:YES];

    [self.subject decline];

    OCMVerify([self.userDefaults setObject:@YES forKey:@"FMIReviewNotificationHasDeclinedKey"]);
    OCMVerify([self.userDefaults synchronize]);
}

- (void)testItShouldSaveTodayWhenUserReviews {
    id today = OCMClassMock([NSDate class]);
    OCMStub([today date]).andReturn([NSDate dateWithTimeIntervalSinceReferenceDate:60]);
    [self.userDefaults setExpectationOrderMatters:YES];

    [self.subject review];

    OCMVerify([self.userDefaults setObject:[NSDate dateWithTimeIntervalSinceReferenceDate:60] forKey:@"FMIReviewNotificationDateOfLastReviewKey"]);
    OCMVerify([self.userDefaults synchronize]);
}

- (void)testItEmbedsTheAppStoreIDInTheURL {
    NSString *urlAsPath = self.subject.reviewURL.absoluteString;

    XCTAssertTrue([urlAsPath containsString:@"::app-store-id::"]);
}

@end
