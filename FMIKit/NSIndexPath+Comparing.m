//
//  NSIndexPath+Comparing.m
//
//  Created by Florian Mielke on 06.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSIndexPath+Comparing.h"


@implementation NSIndexPath (Comparing)


- (BOOL)fm_isEqualToIndexPath:(NSIndexPath *)anotherIndexPath
{
    BOOL isIndexPath = ([anotherIndexPath isKindOfClass:[NSIndexPath class]]);
    
    if (!isIndexPath) {
        return NO;
    }
    
    return ([self compare:anotherIndexPath] == NSOrderedSame);
}


@end
