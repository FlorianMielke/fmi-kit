//
//  NSDecimalNumber+CalculationsTests.m
//
//  Created by Florian Mielke on 14.01.14.
//  Copyright (c) 2014 madeFM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDecimalNumber+Calulations.h"


@interface NSDecimalNumber_CalculationsTests : XCTestCase

@end


@implementation NSDecimalNumber_CalculationsTests


#pragma mark - Tests

- (void)testNumberShouldReturnTrueForNegativeValue
{
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithMantissa:10 exponent:0 isNegative:YES];
    XCTAssertTrue([number fm_isNegative]);
}


- (void)testNumberShouldReturnFalseForPositiveValue
{
    XCTAssertFalse([[NSDecimalNumber one] fm_isNegative]);
}


- (void)testNumberShouldReturnFalseForZeroValue
{
    XCTAssertFalse([[NSDecimalNumber zero] fm_isNegative]);
}


- (void)testNumberShouldInvertPositiveNumber
{

    NSDecimalNumber *positiveOne = [NSDecimalNumber one];
    NSDecimalNumber *negativeOne = [NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:YES];
    
    XCTAssertEqualObjects([positiveOne fm_invertedNumber], negativeOne);
}


- (void)testNumberShouldInvertNegativeNumber
{

    NSDecimalNumber *negativeOne = [NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:YES];
    
    XCTAssertEqualObjects([negativeOne fm_invertedNumber], [NSDecimalNumber one]);
}


- (void)testNumberShouldNotInvertZero
{
    XCTAssertEqualObjects([[NSDecimalNumber zero] fm_invertedNumber], [NSDecimalNumber zero]);
}


- (void)testNumberShouldCalculateModuloOfZeroForOneDevidedByOne
{
    // When
    NSDecimalNumber *modulo = [[NSDecimalNumber one] fm_moduloFor:[NSDecimalNumber one]];
    
    XCTAssertEqualObjects(modulo, [NSDecimalNumber zero]);
}


- (void)testNumberShouldCalculateModuloOfOneForThreeDevidedByTwo
{

    NSDecimalNumber *three = [NSDecimalNumber decimalNumberWithMantissa:3 exponent:0 isNegative:NO];
    NSDecimalNumber *two = [NSDecimalNumber decimalNumberWithMantissa:2 exponent:0 isNegative:NO];
    
    NSDecimalNumber *modulo = [three fm_moduloFor:two];
    
    XCTAssertEqualObjects(modulo, [NSDecimalNumber one]);
}


- (void)testNumberShouldCalculateModuloOfMinusOneForMinusThreeDevidedByTwo
{

    NSDecimalNumber *three = [NSDecimalNumber decimalNumberWithMantissa:3 exponent:0 isNegative:YES];
    NSDecimalNumber *two = [NSDecimalNumber decimalNumberWithMantissa:2 exponent:0 isNegative:NO];
    
    NSDecimalNumber *modulo = [three fm_moduloFor:two];
    
    NSDecimalNumber *expectedModulo = [NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:YES];
    XCTAssertEqualObjects(modulo, expectedModulo);
}


@end