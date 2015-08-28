//
//  NSNumberFormatter+Editing.m
//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSNumberFormatter+Editing.h"


@implementation NSNumberFormatter (Editing)


- (NSString *)fm_editingStringFromNumber:(NSNumber *)number
{
    if (![number isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    
    NSString *formattedNumber = [self stringFromNumber:number];
    return [@([formattedNumber doubleValue] * [self fm_fractionFactor]) stringValue];
}


- (NSNumber *)fm_numberFromEditingString:(NSString *)editingString
{
    if (![editingString isKindOfClass:[NSString class]]) {
        return nil;
    }

    NSNumber *formattedNumber = [self numberFromString:editingString];
    return @([formattedNumber doubleValue] / [self fm_fractionFactor]);
}


- (NSUInteger)fm_fractionFactor
{
    return MAX(1, pow(10, [self minimumFractionDigits]));
}


@end
