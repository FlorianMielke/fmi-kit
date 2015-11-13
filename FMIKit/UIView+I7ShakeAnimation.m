//
//  UIView+I7ShakeAnimation.m
//  
//
//  Created by Jonas Schnelli on 23.01.11.
//  Copyright 2011 include7 AG. All rights reserved.
//

#import "UIView+I7ShakeAnimation.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (I7ShakeAnimation)

- (void)shakeX 
{
	[self shakeXWithOffset:15.0 breakFactor:0.85 duration:0.5 maxShakes:7];
}

- (void)shakeXWithOffset:(CGFloat)aOffset breakFactor:(CGFloat)aBreakFactor duration:(CGFloat)aDuration maxShakes:(NSInteger)maxShakes 
{
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	[animation setDuration:aDuration];
	
	
	NSMutableArray *keys = [NSMutableArray arrayWithCapacity:20];
	NSInteger infinitySec = maxShakes;

	while(aOffset > 0.01) 
	{
		[keys addObject:[NSValue valueWithCGPoint:CGPointMake(self.center.x - aOffset, self.center.y)]];
		aOffset *= aBreakFactor;
		[keys addObject:[NSValue valueWithCGPoint:CGPointMake(self.center.x + aOffset, self.center.y)]];
		aOffset *= aBreakFactor;
		infinitySec--;
	
		if(infinitySec <= 0) {
			break;
		}
	}
	
	[animation setValues:keys];
	
	
	[[self layer] addAnimation:animation forKey:@"position"];
}


- (void)shakeZ
{
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
	
	NSArray *values = [NSArray arrayWithObjects:
						[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.04, 0, 0, 1)],
						[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-0.05, 0, 0, 1)],
						[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.02, 0, 0, 1)],
						[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-0.01, 0, 0, 1)],
						[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.02, 0, 0, 1)],
						[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-0.04, 0, 0, 1)],
						   nil];
	[animation setValues:values];
	
	NSArray *timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn], 
									[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
									nil];
	
	[animation setTimingFunctions:timingFunctions];
	[animation setCumulative:YES];
	[animation setDuration:0.2];
	[animation setRepeatCount:0];
	[animation setAutoreverses:YES];
	[animation setRemovedOnCompletion:YES];
	
	[[self layer] addAnimation:animation forKey:@"transform"];
}

@end
