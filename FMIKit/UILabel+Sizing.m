    //
//  UILabel+Sizing.m
//
//  Created by Florian Mielke on 12/5/11.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

#import "UILabel+Sizing.h"


@implementation UILabel (Sizing)


- (void)sizeToFitFixedWidth:(CGFloat)fixedWidth
{
    CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, 0);
    self.frame = CGRectIntegral(newFrame);
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    [self setNumberOfLines:0];
    [self sizeToFit];
}


@end
