//
//  FMIComparator.h
//
//  Created by Florian Mielke on 13.11.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, FMIComparatorType) {
    FMIComparatorTypeEqualTo = 0,
    FMIComparatorTypeNotEqualTo = 1,
    FMIComparatorTypeGreaterThan = 2,
    FMIComparatorTypeLessThan = 3,
    FMIComparatorTypeGreaterThanOrEqualTo = 4,
    FMIComparatorTypeLessThanOrEqualTo = 5
};



@interface FMIComparator : NSObject

+ (NSString *)formatForType:(FMIComparatorType)type;

@end
