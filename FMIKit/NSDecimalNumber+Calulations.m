//
//  NSDecimalNumber+Calulations.m
//
//  Created by Florian Mielke on 14.01.14.
//  Copyright (c) 2014 madeFM. All rights reserved.
//

#import "NSDecimalNumber+Calulations.h"


@implementation NSDecimalNumber (Calulations)


- (BOOL)fm_isNegative
{
    return (NSOrderedDescending == [[NSDecimalNumber zero] compare:self]);
}


- (NSDecimalNumber *)fm_invertedNumber
{
    NSDecimalNumber *negOne = [NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:YES];
    return [self decimalNumberByMultiplyingBy:negOne];
}


- (NSDecimalNumber *)fm_moduloFor:(NSDecimalNumber *)divisor
{
    NSRoundingMode roundingMode = ([self fm_isNegative] ^ [divisor fm_isNegative]) ? NSRoundUp : NSRoundDown;
    NSDecimalNumberHandler *rounding = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode
                                                                                              scale:0
                                                                                   raiseOnExactness:NO
                                                                                    raiseOnOverflow:NO
                                                                                   raiseOnUnderflow:NO
                                                                                raiseOnDivideByZero:NO];
    
    NSDecimalNumber *quotient = [self decimalNumberByDividingBy:divisor withBehavior:rounding];
    NSDecimalNumber *subtract = [quotient decimalNumberByMultiplyingBy:divisor];
    NSDecimalNumber *modulo = [self decimalNumberBySubtracting:subtract];

    return ([divisor fm_isNegative]) ? [modulo fm_invertedNumber] : modulo;
}


@end
