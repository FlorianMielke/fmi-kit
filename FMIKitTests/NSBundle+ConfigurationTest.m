//
//  NSBundle+ConfigurationTest.m
//
//  Created by Florian Mielke on 17.01.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSBundle+Configuration.h"
#import <OCMock/OCMock.h>

@interface NSBundle_ConfigurationTest : XCTestCase

@end

@implementation NSBundle_ConfigurationTest

- (void)testIsNotBeta {
    id bundleMock = [OCMockObject partialMockForObject:[NSBundle mainBundle]];
    [[[bundleMock stub] andReturn:@"bundleIdentifier"] bundleIdentifier];
    XCTAssertFalse([NSBundle mainBundle].isBeta);
}

- (void)testIsBeta {
    id bundleMock = [OCMockObject partialMockForObject:[NSBundle mainBundle]];
    [[[bundleMock stub] andReturn:@"bundleIdentifier.beta"] bundleIdentifier];
    XCTAssertTrue([NSBundle mainBundle].isBeta);
}

- (void)testIsNotDebug {
    id bundleMock = [OCMockObject partialMockForObject:[NSBundle mainBundle]];
    [[[bundleMock stub] andReturn:@"bundleIdentifier"] bundleIdentifier];
    XCTAssertFalse([NSBundle mainBundle].isDebug);
}

- (void)testIsDebug {
    id bundleMock = [OCMockObject partialMockForObject:[NSBundle mainBundle]];
    [[[bundleMock stub] andReturn:@"bundleIdentifier.debug"] bundleIdentifier];
    XCTAssertTrue([NSBundle mainBundle].isDebug);
}

@end
