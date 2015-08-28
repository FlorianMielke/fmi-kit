//
//  NSArray+Querying.m
//
//  Created by Florian Mielke on 03.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSArray+Querying.h"


@implementation NSArray (Querying)


- (BOOL)containsString:(NSString *)aString
{
    __block BOOL containsString = NO;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:aString])
        {
            containsString = YES;
            *stop = YES;
        }
        
    }];
    
    return containsString;
}


- (BOOL)fm_isEmpty
{
    return ([self count] == 0);
}


- (BOOL)fm_isIndexInBoundsOfArray:(NSUInteger)index
{
    return ([self count] > index);
}


@end
