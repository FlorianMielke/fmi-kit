//
//  UIScrollView+Scrolling.h
//
//  Created by Florian Mielke on 17.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import UIKit;

/**
 *	Adds methods to UIScrollView for handling scrolling;
 */
@interface UIScrollView (Scrolling)

/**
 *	Forces the scroll view to immediate stop scrolling.
 */
- (void)fm_stopScrolling;

@end
