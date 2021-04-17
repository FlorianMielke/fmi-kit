//
//  FMINumericTextView.m
//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMINumericTextView.h"
#import "FMIDuration.h"
#import <FMIKit/FMIKit-Swift.h>

@interface FMINumericTextView ()

@property (NS_NONATOMIC_IOSONLY) BOOL showsKeyboard;
@property (NS_NONATOMIC_IOSONLY) FMINumericTextViewAccessoryButtonType accessoryButtonType;
@property (nullable, NS_NONATOMIC_IOSONLY) UIButton *accessoryButton;
@property (NS_NONATOMIC_IOSONLY) NSNotificationCenter *notificationCenter;
@property (NS_NONATOMIC_IOSONLY) UIToolbar *accessoryView;

@property (NS_NONATOMIC_IOSONLY) UIColor *buttonTintColor;
@property (NS_NONATOMIC_IOSONLY) UIColor *buttonBackgroundColor;

@end

@implementation FMINumericTextView

@dynamic delegate;

#pragma mark - Initialization

- (instancetype)init {
    return [self initWithAccessoryButtonType:FMINumericTextViewAccessoryButtonTypeNone buttonTintColor:[UIColor systemBlueColor] buttonBackgroundColor:[UIColor systemBackgroundColor]];
}

- (instancetype)initWithAccessoryButtonType:(FMINumericTextViewAccessoryButtonType)accessoryButtonType buttonTintColor:(UIColor *)buttonTintColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor {
    return [self initWithAccessoryButtonType:accessoryButtonType buttonTintColor:buttonTintColor buttonBackgroundColor:buttonBackgroundColor notificationCenter:[NSNotificationCenter defaultCenter]];
}

- (instancetype)initWithAccessoryButtonType:(FMINumericTextViewAccessoryButtonType)accessoryButtonType buttonTintColor:(UIColor *)buttonTintColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor notificationCenter:(NSNotificationCenter *)notificationCenter {
    self = [super init];
    
    if (self != nil) {
        self.buttonTintColor = buttonTintColor;
        self.buttonBackgroundColor = buttonBackgroundColor;
        self.durationStyle = FMIDurationFormatterStyleTime;
        self.accessoryButtonType = accessoryButtonType;
        self.notificationCenter = notificationCenter;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return self;
}

- (UIView *)inputAccessoryView {
    if (_accessoryView == nil && self.accessoryButton != nil) {
        UIToolbar *toolbar = [UIToolbar makeTransparent];
        toolbar.items = @[[UIBarButtonItem flexibleSpaceItem], [[UIBarButtonItem alloc] initWithCustomView:self.accessoryButton]];
        [toolbar sizeToFit];
        _accessoryView = toolbar;
    }
    
    return _accessoryView;
}

#pragma mark - Toggle keyboard

- (void)toggleKeyboard {
    self.showsKeyboard = !(self.showsKeyboard);
    [self askDelegateAboutBalancedToggleForCompoundTextViewsIfNeeded];
    
    if (self.showsKeyboard) {
        [self becomeFirstResponder];
    } else {
        [self resignFirstResponder];
    }
}

- (void)askDelegateAboutBalancedToggleForCompoundTextViewsIfNeeded {
    if (self.showsKeyboard && self.delegate != nil && [self.delegate respondsToSelector:@selector(compoundTextViewsForTextView:)]) {
        NSArray *compoundTextViews = [self.delegate compoundTextViewsForTextView:self];
        [compoundTextViews enumerateObjectsUsingBlock:^(FMINumericTextView *compoundTextView, NSUInteger idx, BOOL *stop) {
            if (![compoundTextView isEqual:self] && compoundTextView.showsKeyboard) {
                compoundTextView.showsKeyboard = NO;
            }
        }];
    }
}

#pragma mark - Clear text

- (IBAction)clearText:(id)sender {
    self.text = [self clearedText];
    [self informDelegateAboutClearingText];
}

- (NSString *)clearedText {
    return ([self.text hasPrefix:@"-"]) ? @"-" : @"";
}

- (void)informDelegateAboutClearingText {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(textViewDidClearText:)]) {
        [self.delegate textViewDidClearText:self];
    }
}

#pragma mark - Invert text

- (IBAction)invertText:(id)sender {
    self.text = [self invertedText];
    [self informDelegateAboutInvertingText];
}

- (NSString *)invertedText {
    return ([self.text hasPrefix:@"-"]) ? [self.text substringFromIndex:1] : [NSString stringWithFormat:@"-%@", self.text];
}

- (void)informDelegateAboutInvertingText {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(textViewDidInvertText:)]) {
        [self.delegate textViewDidInvertText:self];
    }
}

#pragma mark - Keyboard notifications

- (BOOL)becomeFirstResponder {
    [self registerForKeyboardAppearanceNotification];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    self.showsKeyboard = NO;
    return [super resignFirstResponder];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self removeFromKeyboardAppearanceNotification];
    self.showsKeyboard = NO;
}

- (void)registerForKeyboardAppearanceNotification {
    if (self.accessoryButtonType != FMINumericTextViewAccessoryButtonTypeNone) {
        [self.notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)removeFromKeyboardAppearanceNotification {
    if (self.accessoryButtonType != FMINumericTextViewAccessoryButtonTypeNone) {
        [self.notificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

#pragma mark - Prepare clear button

- (UIButton *)accessoryButton {
    if (_accessoryButton == nil && self.accessoryButtonType != FMINumericTextViewAccessoryButtonTypeNone) {
        _accessoryButton = (self.accessoryButtonType == FMINumericTextViewAccessoryButtonTypeClear) ? [self clearButton] : [self invertButton];
    }
    
    return _accessoryButton;
}

- (UIButton *)clearButton {
    FMIDurationFormatter *durationFormatter = [[FMIDurationFormatter alloc] init];
    durationFormatter.style = self.durationStyle;

    UIButton *button = [UIButton makeWithCornerRadius:6.0 title:[durationFormatter stringFromDuration:[FMIDuration zero]] tintColor:self.buttonTintColor backgroundColor:self.buttonBackgroundColor];
    [button addTarget:self action:@selector(clearText:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIButton *)invertButton {
    UIButton *button = [UIButton makeWithCornerRadius:6.0 systemName:@"plus.slash.minus" tintColor:self.buttonTintColor backgroundColor:self.buttonBackgroundColor];
    [button addTarget:self action:@selector(invertText:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
