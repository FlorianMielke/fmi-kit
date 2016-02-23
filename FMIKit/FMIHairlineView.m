#import "FMIHairlineView.h"

@implementation FMIHairlineView

- (instancetype)initWithLineColor:(UIColor *)lineColor {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.borderColor = [lineColor CGColor];
        self.layer.borderWidth = (CGFloat) (1.0 / [UIScreen mainScreen].scale);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (CGSize)intrinsicContentSize{
    return CGSizeMake(UIViewNoIntrinsicMetric, (CGFloat) (1.0 / [UIScreen mainScreen].scale));
}

@end
