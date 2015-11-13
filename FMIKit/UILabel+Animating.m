#import "UILabel+Animating.h"

static NSString *const GlowAnimationKey = @"glowAnimation";

@implementation UILabel (Animating)

- (void)glow {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    animation.duration = 0.8;
    animation.fromValue = @1.0;
    animation.toValue = @0.2;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:GlowAnimationKey];
}

- (void)stopGlowing {
    [CATransaction begin];
    [self.layer removeAnimationForKey:GlowAnimationKey];
    [CATransaction commit];
}

- (void)setTextAnimated:(NSString *)text {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"changeTextTransition"];
    self.text = text;
}

@end