//
//  FMIBorderedButton.m
//
//  Created by Florian Mielke on 22.12.14.
//  Copyright (c) 2014 madeFM. All rights reserved.
//

#import "FMIBorderedButton.h"

@implementation FMIBorderedButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.hasInvertedColors = NO;
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = self.tintColor.CGColor;
        self.layer.cornerRadius = 6.0;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (self.isEnabled && self.tintAdjustmentMode == UIViewTintAdjustmentModeNormal) {
        self.layer.borderColor = (highlighted) ? [[self.tintColor colorWithAlphaComponent:0.2] CGColor] : self.tintColor.CGColor;
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (self.tintAdjustmentMode == UIViewTintAdjustmentModeNormal) {
        self.layer.borderColor = (enabled) ? self.tintColor.CGColor : [UIColor lightGrayColor].CGColor;
    }
}

- (void)tintColorDidChange {
    UIColor *titleColor;
    if (self.hasInvertedColors) {
        titleColor = [UIColor whiteColor];
        self.backgroundColor = (self.tintAdjustmentMode == UIViewTintAdjustmentModeNormal) ? self.tintColor : [UIColor lightGrayColor];
    } else {
        titleColor = (self.tintAdjustmentMode == UIViewTintAdjustmentModeNormal) ? self.tintColor : [UIColor lightGrayColor];
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    self.layer.borderColor = (self.isEnabled && self.tintAdjustmentMode == UIViewTintAdjustmentModeNormal) ? self.tintColor.CGColor : [UIColor lightGrayColor].CGColor;
}

@end
