#import "UILabel+Animating.h"

static NSString *const GlowAnimationKey = @"glowAnimation";

@implementation UILabel (Animating)

- (void)setTextAnimated:(NSString *)text {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"changeTextTransition"];
    self.text = text;
}

@end
