//
//  Created by Florian Mielke on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMISupportMessage.h"
#import "UIDevice+Platform.h"


@interface FMISupportMessageTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMISupportMessage *sut;

@end



@implementation FMISupportMessageTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];
    
    id mockBundle = [OCMockObject mockForClass:[NSBundle class]];
    [[[mockBundle stub] andReturn:[self infoDictionary]] infoDictionary];
    
    _sut = [[FMISupportMessage alloc] initWithBundle:mockBundle];
}


- (void)tearDown
{
    [self setSut:nil];
    
    [super tearDown];
}


- (NSDictionary *)infoDictionary
{
    return @{@"CFBundleDisplayName": @"FMFramework"
             , @"CFBundleShortVersionString": @"4.0"
             , @"CFBundleVersion": @"400"};
}



#pragma mark - Initialization

- (void)testComposerIsInitialized
{
    XCTAssertNotNil([self sut]);
}


- (void)testComposerConformsToProtocols
{
    XCTAssertTrue([[self sut] conformsToProtocol:@protocol(FMIMessage)]);
}



#pragma mark - Recipients

- (void)testToRecipientsReturnsCorrectSupportMail
{
    XCTAssertEqualObjects([[[self sut] toRecipients] lastObject], @"feedback@madefm.com");
}



#pragma mark - Subject

- (void)testSubjectIsNotNil
{
    XCTAssertNotNil([[self sut] subject]);
}


- (void)testSubjectContainsNameOfApp
{

    NSString *nameOfApp = [self infoDictionary][@"CFBundleDisplayName"];
    
    NSRange nameOfAppRange = [[[self sut] subject] rangeOfString:nameOfApp];
    XCTAssertTrue(nameOfAppRange.location != NSNotFound);
}


- (void)testSubjectContainsVersionOfApp
{

    NSString *versionOfApp = [self infoDictionary][@"CFBundleShortVersionString"];

    // Then
    NSRange versionOfAppRange = [[[self sut] subject] rangeOfString:versionOfApp];
    XCTAssertTrue(versionOfAppRange.location != NSNotFound);
}


- (void)testSubjectContainsBuildVersionOfApp
{

    NSString *buildVersionOfApp = [self infoDictionary][@"CFBundleVersion"];
    
    NSRange buildVersionOfAppRange = [[[self sut] subject] rangeOfString:buildVersionOfApp];
    XCTAssertTrue(buildVersionOfAppRange.location != NSNotFound);
}



#pragma mark - Body

- (void)testBodyIsNotNil
{
    XCTAssertNotNil([[self sut] messageBody]);
}


- (void)testBodyContainsIOSVersion
{

    NSString *iOSVersion = [[UIDevice currentDevice] systemVersion];
    
    NSRange iOSVersionRange = [[[self sut] messageBody] rangeOfString:iOSVersion];
    XCTAssertTrue(iOSVersionRange.location != NSNotFound);
}


- (void)testBodyContainsIOSDevice
{

    NSString *iOSDevice = [[UIDevice currentDevice] platform];
    
    NSRange iOSDeviceRange = [[[self sut] messageBody] rangeOfString:iOSDevice];
    XCTAssertTrue(iOSDeviceRange.location != NSNotFound);
}


- (void)testBodyContainsSystemLanguage
{

    NSString *systemLanguage = [[NSLocale preferredLanguages] firstObject];
    
    NSRange systemLanguageRange = [[[self sut] messageBody] rangeOfString:systemLanguage];
    XCTAssertTrue(systemLanguageRange.location != NSNotFound);
}

@end
