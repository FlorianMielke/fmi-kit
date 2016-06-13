#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMIWhatsNewCoordinator.h"
#import "NSLocale+German.h"
#import "FMIURLProvider.h"

@interface FMIWhatsNewCoordinatorTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIWhatsNewCoordinator *subject;
@property (NS_NONATOMIC_IOSONLY) id userDefaults;
@property (NS_NONATOMIC_IOSONLY) id bundle;
@property (NS_NONATOMIC_IOSONLY) id URLProvider;

@end

@implementation FMIWhatsNewCoordinatorTest

- (void)setUp {
    [super setUp];
    self.bundle = OCMClassMock([NSBundle class]);
    self.userDefaults = OCMClassMock([NSUserDefaults class]);
    self.URLProvider = OCMProtocolMock(@protocol(FMIURLProvider));
    self.subject = [[FMIWhatsNewCoordinator alloc] initWithBundle:self.bundle userDefaults:self.userDefaults URLProvider:self.URLProvider];
}

- (void)testItReturnsTrueIfItsANewVersionAndTheUserHasNotViewedAnyVersionYet {
    NSDictionary *infoDictionary = @{@"CFBundleShortVersionString" : @"1"};
    OCMStub([self.bundle infoDictionary]).andReturn(infoDictionary);
    OCMStub([self.userDefaults objectForKey:@"FMIWhatsNewLastViewedVersionKey"]).andReturn(nil);

    BOOL shouldShow = self.subject.shouldShow;

    XCTAssertTrue(shouldShow);
}

- (void)testItReturnsTrueIfItsANewVersion {
    NSDictionary *infoDictionary = @{@"CFBundleShortVersionString" : @"2"};
    OCMStub([self.bundle infoDictionary]).andReturn(infoDictionary);
    OCMStub([self.userDefaults objectForKey:@"FMIWhatsNewLastViewedVersionKey"]).andReturn(@"1");

    BOOL shouldShow = self.subject.shouldShow;

    XCTAssertTrue(shouldShow);
}

- (void)testItReturnsFalseIfItsNotANewVersion {
    NSDictionary *infoDictionary = @{@"CFBundleShortVersionString" : @"1"};
    OCMStub([self.bundle infoDictionary]).andReturn(infoDictionary);
    OCMStub([self.userDefaults objectForKey:@"FMIWhatsNewLastViewedVersionKey"]).andReturn(@"1");

    BOOL shouldShow = self.subject.shouldShow;

    XCTAssertFalse(shouldShow);
}

- (void)testItStoresTheCurrentVersionWhenViewedWhatsNewHint {
    NSDictionary *infoDictionary = @{@"CFBundleShortVersionString" : @"2"};
    OCMStub([self.bundle infoDictionary]).andReturn(infoDictionary);

    [self.userDefaults setExpectationOrderMatters:YES];

    [self.subject viewed];

    OCMVerify([self.userDefaults setObject:@"2" forKey:@"FMIWhatsNewLastViewedVersionKey"]);
    OCMVerify([self.userDefaults synchronize]);
}

- (void)testItLocalizesWhatsNewURLForGerman {
    NSURL *sampleURL = [NSURL URLWithString:@"http://sample.com/helpcenter"];
    OCMStub([self.URLProvider provideURL]).andReturn(sampleURL);
    
    NSURL *url = self.subject.localizedWhatsNewURL;
    
    XCTAssertEqualObjects(sampleURL.absoluteString, url.absoluteString);
}

@end
