#import "FMIBlurredView.h"
#import "FMIHairlineView.h"

@interface FMIBlurredView ()

@property (NS_NONATOMIC_IOSONLY) UIVisualEffectView *blurredView;
@property (NS_NONATOMIC_IOSONLY) FMIHairlineView *topHairline;
@property (NS_NONATOMIC_IOSONLY) FMIHairlineView *bottomHairline;
@property (NS_NONATOMIC_IOSONLY) UIColor *initialBackgroundColor;

@end

@implementation FMIBlurredView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.initialBackgroundColor = self.backgroundColor;
        self.showBlurredBackground = YES;
        self.showTopHairline = NO;
        self.showBottomHairline = NO;
        self.blurredView = [self prepareVisualEffectView];
        [self insertSubview:self.blurredView atIndex:0];
        UIVisualEffectView *blurredView = self.blurredView;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[blurredView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(blurredView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[blurredView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(blurredView)]];

        UIColor *hairlineColor = [UIColor colorWithRed:0.737 green:0.729 blue:0.757 alpha:1.0];
        self.topHairline = [[FMIHairlineView alloc] initWithLineColor:hairlineColor];
        [self insertSubview:self.topHairline atIndex:1];
        [self layoutTopHairline];

        self.bottomHairline = [[FMIHairlineView alloc] initWithLineColor:hairlineColor];
        [self insertSubview:self.bottomHairline atIndex:1];
        [self layoutBottomHairline];
    }
    return self;
}

- (void)layoutTopHairline {
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.topHairline attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.topHairline attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topHairline attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    [self addConstraints:@[topConstraint, leftConstraint, rightConstraint]];
}

- (void)layoutBottomHairline {
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bottomHairline attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bottomHairline attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomHairline attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    [self addConstraints:@[bottomConstraint, leftConstraint, rightConstraint]];
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
    self.backgroundColor = (_showBlurredBackground) ? [UIColor clearColor] : self.initialBackgroundColor;
}

- (void)setShowTopHairline:(BOOL)showTopHairline {
    _showTopHairline = showTopHairline;
    self.topHairline.hidden = !_showTopHairline;
}

- (void)setShowBottomHairline:(BOOL)showBottomHairline {
    _showBottomHairline = showBottomHairline;
    self.bottomHairline.hidden = !_showBottomHairline;
}

@end
