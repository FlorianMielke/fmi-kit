//
//  FMINumericTextView.m
//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMINumericTextView.h"
#import "FMIDuration.h"
#import "UIDevice+Platform.h"
#import <FMIKit/FMIKit-Swift.h>

@interface FMINumericTextView ()

@property (NS_NONATOMIC_IOSONLY) BOOL showsKeyboard;
@property (NS_NONATOMIC_IOSONLY) FMINumericTextViewAccessoryButtonType accessoryButtonType;
@property (nullable, NS_NONATOMIC_IOSONLY) UIButton *accessoryButton;
@property (NS_NONATOMIC_IOSONLY) NSNotificationCenter *notificationCenter;
@property (NS_NONATOMIC_IOSONLY) UIToolbar *accessoryView;

@property (NS_NONATOMIC_IOSONLY) UIColor *buttonTintColor;
@property (NS_NONATOMIC_IOSONLY) UIColor *buttonBackgroundColor;
@property (readonly, NS_NONATOMIC_IOSONLY) NSString *titleForClearButton;
@property (readonly, NS_NONATOMIC_IOSONLY) NSString *titleForInvertButton;

@end

@implementation FMINumericTextView

@dynamic delegate;

#pragma mark - Initialization

- (instancetype)init {
    return [self initWithAccessoryButtonType:FMINumericTextViewAccessoryButtonTypeNone buttonTintColor:[UIColor systemBlueColor] buttonBackgroundColor:[UIColor systemBackgroundColor] durationStyle:FMIDurationFormatterStyleTime];
}

- (instancetype)initWithAccessoryButtonType:(FMINumericTextViewAccessoryButtonType)accessoryButtonType buttonTintColor:(UIColor *)buttonTintColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor durationStyle:(enum FMIDurationFormatterStyle)durationStyle {
    return [self initWithAccessoryButtonType:accessoryButtonType buttonTintColor:buttonTintColor buttonBackgroundColor:buttonBackgroundColor  durationStyle:durationStyle notificationCenter:[NSNotificationCenter defaultCenter]];
}

- (instancetype)initWithAccessoryButtonType:(FMINumericTextViewAccessoryButtonType)accessoryButtonType buttonTintColor:(UIColor *)buttonTintColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor durationStyle:(enum FMIDurationFormatterStyle)durationStyle notificationCenter:(NSNotificationCenter *)notificationCenter {
    self = [super init];
    
    if (self != nil) {
        self.buttonTintColor = buttonTintColor;
        self.buttonBackgroundColor = buttonBackgroundColor;
        self.durationStyle = durationStyle;
        self.accessoryButtonType = accessoryButtonType;
        self.notificationCenter = notificationCenter;
        self.keyboardType = UIKeyboardTypeNumberPad;
        [self applyInputAssistantItem];
    }
    
    return self;
}

- (UIView *)inputAccessoryView {
    /// Don't show the accessory view on an iPad, as we are there using the InputAssistantItem
    if (_accessoryView == nil && self.accessoryButton != nil && !UIDevice.currentDevice.isIPad) {
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

#pragma mark - Prepare buttons

- (void)applyInputAssistantItem {
    UIBarButtonItem *buttonItem = [self inputAssistantButtonItem];
    if (buttonItem == nil) {
        return;
    }

    UITextInputAssistantItem *inputAssistant = self.inputAssistantItem;
    UIBarButtonItemGroup *group = [[UIBarButtonItemGroup alloc] initWithBarButtonItems:@[buttonItem] representativeItem:nil];
    inputAssistant.trailingBarButtonGroups = @[group];
}

- (nullable UIBarButtonItem *)inputAssistantButtonItem {
    switch (self.accessoryButtonType) {
        case FMINumericTextViewAccessoryButtonTypeNone:
            return nil;
            break;
            
        case FMINumericTextViewAccessoryButtonTypeInvert: {
            UIImage *image = [UIImage systemImageNamed:self.titleForInvertButton];
            return [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(invertText:)];
            break;
        }

        case FMINumericTextViewAccessoryButtonTypeClear:
            return [[UIBarButtonItem alloc] initWithTitle:self.titleForClearButton style:UIBarButtonItemStylePlain target:self action:@selector(clearText:)];
            break;
    }
}

- (UIButton *)accessoryButton {
    if (_accessoryButton == nil && self.accessoryButtonType != FMINumericTextViewAccessoryButtonTypeNone) {
        _accessoryButton = (self.accessoryButtonType == FMINumericTextViewAccessoryButtonTypeClear) ? [self clearButton] : [self invertButton];
    }
    
    return _accessoryButton;
}

- (UIButton *)clearButton {
    RoundedButton *button = [[RoundedButton alloc] initWithTitle:self.titleForClearButton cornerRadius:6.0 tintColor:self.buttonTintColor backgroundColor:self.buttonBackgroundColor];
    [button addTarget:self action:@selector(clearText:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIButton *)invertButton {
    RoundedButton *button = [[RoundedButton alloc] initWithSystemName:self.titleForInvertButton cornerRadius:6.0 tintColor:self.buttonTintColor backgroundColor:self.buttonBackgroundColor];
    [button addTarget:self action:@selector(invertText:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (NSString *)titleForClearButton {
    FMIDurationFormatter *durationFormatter = [[FMIDurationFormatter alloc] init];
    durationFormatter.style = self.durationStyle;
    return [durationFormatter stringFromDuration:[FMIDuration zero]];
}

- (NSString *)titleForInvertButton {
    return @"plus.slash.minus";
}

@end
