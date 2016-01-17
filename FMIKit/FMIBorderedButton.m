//
//  FMIBorderedButton.m
//
//  Created by Florian Mielke on 22.12.14.
//  Copyright (c) 2014 madeFM. All rights reserved.
//

#import "FMIBorderedButton.h"

@implementation FMIBorderedButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = self.tintColor.CGColor;
    self.layer.cornerRadius = 3.0;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.layer.borderColor = (highlighted) ? self.tintColor.CGColor : self.tintColor.CGColor;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    self.layer.borderColor = (enabled) ? self.tintColor.CGColor : [UIColor lightGrayColor].CGColor;
}

- (void)tintColorDidChange {
    UIColor *titleColor = (self.tintAdjustmentMode == UIViewTintAdjustmentModeNormal) ? self.tintColor : [UIColor lightGrayColor];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    self.layer.borderColor = (self.tintAdjustmentMode == UIViewTintAdjustmentModeNormal) ? self.tintColor.CGColor : [UIColor lightGrayColor].CGColor;
}

@end
