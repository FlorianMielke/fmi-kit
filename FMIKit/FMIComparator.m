//
//  FMIComparator.m
//
//  Created by Florian Mielke on 13.11.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIComparator.h"


@implementation FMIComparator


+ (NSString *)formatForType:(FMIComparatorType)type
{
    return [[self class] formats][@(type)];
}


+ (NSDictionary *)formats
{
    return @{@(FMIComparatorTypeEqualTo): @"%K == %@",
             @(FMIComparatorTypeNotEqualTo): @"%K != %@",
             @(FMIComparatorTypeGreaterThan): @"%K > %@",
             @(FMIComparatorTypeLessThan): @"%K < %@",
             @(FMIComparatorTypeGreaterThanOrEqualTo): @"%K >= %@",
             @(FMIComparatorTypeLessThanOrEqualTo): @"%K <= %@"};
}


@end
