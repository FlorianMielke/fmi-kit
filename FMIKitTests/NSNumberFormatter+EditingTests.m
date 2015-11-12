//
//  NSNumberFormatter+EditingTests.m
//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSNumberFormatter+Editing.h"


@interface NSNumberFormatter_EditingTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) NSNumberFormatter *sut;

@end



@implementation NSNumberFormatter_EditingTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    _sut = [[NSNumberFormatter alloc] init];
}


- (void)tearDown
{
    _sut = nil;
    
    [super tearDown];
}



#pragma mark - Editing string

- (void)testFormatterShouldNotAcceptNonNumber
{
    XCTAssertNil([_sut fm_editingStringFromNumber:(NSNumber *)@"30"]);
}


- (void)testFormatterShouldReturnEditingStringFromNumber
{
    [self verifyFormatterReturnsEditingString:@"30" fromNumber:@30 usingFractionDigits:0];
    [self verifyFormatterReturnsEditingString:@"300" fromNumber:@30.0 usingFractionDigits:1];
    [self verifyFormatterReturnsEditingString:@"3000" fromNumber:@30.00 usingFractionDigits:2];
    [self verifyFormatterReturnsEditingString:@"3010" fromNumber:@30.1 usingFractionDigits:2];
}



#pragma mark - Number from editing string

- (void)testFormatterShouldNotAcceptNonString
{
    XCTAssertNil([_sut fm_numberFromEditingString:(NSString *)@30]);
}


- (void)testFormatterShouldReturnNumberFromEditingString
{
    [self verifyFormatterReturnsNumber:@30 fromEditingString:@"30" usingFractionDigits:0];
    [self verifyFormatterReturnsNumber:@30.1 fromEditingString:@"301" usingFractionDigits:1];
    [self verifyFormatterReturnsNumber:@30.75 fromEditingString:@"3075" usingFractionDigits:2];
}



#pragma mark - Utilities

- (void)verifyFormatterReturnsNumber:(NSNumber *)number fromEditingString:(NSString *)editingString usingFractionDigits:(NSUInteger)fractionDigits
{

    [_sut setMinimumFractionDigits:fractionDigits];
    
    XCTAssertEqualObjects(number, [_sut fm_numberFromEditingString:editingString]);
}


- (void)verifyFormatterReturnsEditingString:(NSString *)editingString fromNumber:(NSNumber *)number usingFractionDigits:(NSUInteger)fractionDigits
{

    [_sut setMinimumFractionDigits:fractionDigits];
    
    XCTAssertEqualObjects(editingString, [_sut fm_editingStringFromNumber:number]);
}

@end
