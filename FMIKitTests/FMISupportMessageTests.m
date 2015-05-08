//
//  Created by Florian Mielke on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "FMISupportMessage.h"
#import "UIDevice+Platform.h"


@interface FMISupportMessageTests : XCTestCase

@property (nonatomic, strong) FMISupportMessage *sut;

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
    XCTAssertTrue([[self sut] conformsToProtocol:@protocol(FMMessage)]);
}



#pragma mark - Recipients

- (void)testToRecipientsReturnsCorrectSupportMail
{
    XCTAssertEqualObjects([[[self sut] toRecipients] lastObject], @"support@madefm.com");
}



#pragma mark - Subject

- (void)testSubjectIsNotNil
{
    XCTAssertNotNil([[self sut] subject]);
}


- (void)testSubjectContainsNameOfApp
{
    // Given
    NSString *nameOfApp = [[self infoDictionary] objectForKey:@"CFBundleDisplayName"];
    
    // Then
    NSRange nameOfAppRange = [[[self sut] subject] rangeOfString:nameOfApp];
    XCTAssertTrue(nameOfAppRange.location != NSNotFound);
}


- (void)testSubjectContainsVersionOfApp
{
    // Given
    NSString *versionOfApp = [[self infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    // Then
    NSRange versionOfAppRange = [[[self sut] subject] rangeOfString:versionOfApp];
    XCTAssertTrue(versionOfAppRange.location != NSNotFound);
}


- (void)testSubjectContainsBuildVersionOfApp
{
    // Given
    NSString *buildVersionOfApp = [[self infoDictionary] objectForKey:@"CFBundleVersion"];
    
    // Then
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
    // Given
    NSString *iOSVersion = [[UIDevice currentDevice] systemVersion];
    
    // Then
    NSRange iOSVersionRange = [[[self sut] messageBody] rangeOfString:iOSVersion];
    XCTAssertTrue(iOSVersionRange.location != NSNotFound);
}


- (void)testBodyContainsIOSDevice
{
    // Given
    NSString *iOSDevice = [[UIDevice currentDevice] platform];
    
    // Then
    NSRange iOSDeviceRange = [[[self sut] messageBody] rangeOfString:iOSDevice];
    XCTAssertTrue(iOSDeviceRange.location != NSNotFound);
}


- (void)testBodyContainsSystemLanguage
{
    // Given
    NSString *systemLanguage = [[NSLocale preferredLanguages] firstObject];
    
    // Then
    NSRange systemLanguageRange = [[[self sut] messageBody] rangeOfString:systemLanguage];
    XCTAssertTrue(systemLanguageRange.location != NSNotFound);
}

@end
