//
//  Created by Jonas Schnelli on 23.01.11.
//  Copyright 2011 include7 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (I7ShakeAnimation)

- (void)shakeX;
- (void)shakeZ;

- (void)shakeXWithOffset:(CGFloat)aOffset breakFactor:(CGFloat)aBreakFactor duration:(CGFloat)aDuration maxShakes:(NSInteger)maxShakes;

@end
