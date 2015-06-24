//
//  UIDevice+PlatformTests.m
//
//  Created by Florian Mielke on 09.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "UIDevice+Platform.h"

@interface UIDevice_PlatformTests : XCTestCase
@end

@implementation UIDevice_PlatformTests

#pragma mark - Platform identifier

- (void)testPlatformIdentifierReturnsIdentifierForSimulator
{
	XCTAssertEqualObjects([[UIDevice currentDevice] platformIdentifier], @"x86_64");
}

#pragma mark - Platform

- (void)testPlatformReturnsSimulatorString
{
	XCTAssertEqualObjects([[UIDevice currentDevice] platform], @"Simulator");
}

- (void)testPlattformReturnsiPhoneString
{
	id mockDevice = [OCMockObject mockForClass:[UIDevice class]];
	[[[mockDevice stub] andReturn:@"iPhone1,1"] platformIdentifier];
	[[[mockDevice expect] andReturn:@"iPhone 1G"] platform];

	[mockDevice platform];

	XCTAssertNoThrow([mockDevice verify]);
}

- (void)testDeviceShouldCheckIOS8SystemVersion
{
	[self verifyThatGivenVersion:@"7.1.0" isIOS8:NO];
	[self verifyThatGivenVersion:@"8.0.0" isIOS8:YES];
	[self verifyThatGivenVersion:@"8.0.1" isIOS8:YES];
}

- (void)verifyThatGivenVersion:(NSString *)version isIOS8:(BOOL)isIOS8
{
	id mockDevice = [OCMockObject partialMockForObject:[UIDevice currentDevice]];
	[(UIDevice *)[[mockDevice stub] andReturn:version] systemVersion];

	XCTAssertEqual([mockDevice isIOS8], isIOS8);
	[mockDevice stopMocking];
}

@end
