//
//  UIScrollView+Scrolling.m
//
//  Created by Florian Mielke on 17.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "UIScrollView+Scrolling.h"

@implementation UIScrollView (Scrolling)

- (void)fm_stopScrolling {
    if (self.decelerating) {
        [self setContentOffset:self.contentOffset animated:NO];
    }
}

@end
