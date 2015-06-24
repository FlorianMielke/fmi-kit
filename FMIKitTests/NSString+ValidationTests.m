//
//  NSString+ValidationTests.m
//
//  Created by Florian Mielke on 25.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "NSString+Validation.h"


@interface NSString_ValidationTests : XCTestCase

@end


@implementation NSString_ValidationTests

#pragma mark -
#pragma mark Is numberic

- (void)testNumericValidationReturnsYESForNumericString
{
    XCTAssertTrue([@"12345" isNumeric]);
}


- (void)testNumericValidationReturnsNoForNonNumericString
{
    XCTAssertFalse([@"12 3A123." isNumeric]);
}


@end
