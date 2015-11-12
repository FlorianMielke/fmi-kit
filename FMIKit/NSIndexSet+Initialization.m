//
//  NSIndexSet+Initialization.m
//
//  Created by Florian Mielke on 16.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSIndexSet+Initialization.h"


@implementation NSIndexSet (Initialization)


+ (NSIndexSet *)indexSetWithArray:(NSArray *)anArray
{
    __block NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    
    [anArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        if ([obj isKindOfClass:[NSNumber class]]) {
            [indexSet addIndex:[obj integerValue]];
        }
     
    }];
    
    return indexSet;
}


@end
