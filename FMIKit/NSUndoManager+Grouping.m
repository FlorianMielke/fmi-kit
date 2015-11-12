//
//  NSUndoManager+Grouping.m
//
//  Created by Florian Mielke on 27.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSUndoManager+Grouping.h"


@implementation NSUndoManager (Grouping)


- (void)savelyEndUndoGrouping
{
    if ([self groupingLevel] > 0) {
        [self endUndoGrouping];
    }
}


- (void)savelyBeginUndoGrouping
{
    if ([self groupingLevel] == 0) {
        [self beginUndoGrouping];
    }
}


@end
