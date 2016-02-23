#import "FMIBlurredView.h"
#import "FMIHairlineView.h"

@interface FMIBlurredView ()

@property (NS_NONATOMIC_IOSONLY) UIVisualEffectView *blurredView;

@end

@implementation FMIBlurredView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.showBlurredBackground = YES;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        self.blurredView = [self prepareVisualEffectView];
        [self insertSubview:self.blurredView atIndex:0];
        UIVisualEffectView *blurredView = self.blurredView;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[blurredView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(blurredView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[blurredView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(blurredView)]];
        
        UIColor *hairlineColor = [UIColor colorWithRed:0.737 green:0.729 blue:0.757 alpha:1.0];
        FMIHairlineView *bottomHairline = [[FMIHairlineView alloc] initWithLineColor:hairlineColor];
        [self insertSubview:bottomHairline atIndex:1];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:bottomHairline attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:bottomHairline attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomHairline attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
        [self addConstraints:@[bottomConstraint, leftConstraint, rightConstraint]];
    }
    return self;
}

- (UIVisualEffectView *)prepareVisualEffectView {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:effect];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

- (void)setShowBlurredBackground:(BOOL)showBlurredBackground {
    _showBlurredBackground = showBlurredBackground;
    self.blurredView.hidden = !_showBlurredBackground;
    self.backgroundColor = (_showBlurredBackground) ? [UIColor clearColor] : [UIColor whiteColor];
}

@end
