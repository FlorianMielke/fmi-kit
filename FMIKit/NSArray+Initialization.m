//
//  NSArray+Initialization.m
//
//  Created by Florian Mielke on 15.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSArray+Initialization.h"


@implementation NSArray (Initialization)


+ (NSArray *)arrayWithIndexes:(NSIndexSet *)indexes
{
    __block NSMutableArray *anArray = [NSMutableArray arrayWithCapacity:[indexes count]];
    
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [anArray addObject:@(idx)];
    }];
    
    return anArray;
}


@end
