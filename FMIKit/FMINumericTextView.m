//
//  FMINumericTextView.m
//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMINumericTextView.h"
#import "UIImage+Creation.h"
#import "FMIDurationFormatter.h"
#import "FMIDuration.h"

@interface FMINumericTextView () <UIToolbarDelegate>

@property (NS_NONATOMIC_IOSONLY) BOOL showsKeyboard;
@property (NS_NONATOMIC_IOSONLY) FMINumericTextViewAccessoryButtonType accessoryButtonType;
@property (NS_NONATOMIC_IOSONLY) UIBarButtonItem *accessoryButton;
@property (NS_NONATOMIC_IOSONLY) NSNotificationCenter *notificationCenter;
@property (NS_NONATOMIC_IOSONLY) UIToolbar *accessoryView;

@end

@implementation FMINumericTextView

@dynamic delegate;

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithAccessoryButtonType:FMINumericTextViewAccessoryButtonTypeNone notificationCenter:[NSNotificationCenter defaultCenter]];
}

- (instancetype)initWithAccessoryButtonType:(FMINumericTextViewAccessoryButtonType)accessoryButtonType
{
    return [self initWithAccessoryButtonType:accessoryButtonType notificationCenter:[NSNotificationCenter defaultCenter]];
}

- (instancetype)initWithAccessoryButtonType:(FMINumericTextViewAccessoryButtonType)accessoryButtonType notificationCenter:(NSNotificationCenter *)notificationCenter
{
    self = [super init];
    
    if (self != nil)
    {
        self.durationStyle = FMIDurationFormatterStyleTime;
        self.accessoryButtonType = accessoryButtonType;
        self.notificationCenter = notificationCenter;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return self;
}

- (UIView *)inputAccessoryView
{
    if (!_accessoryView)
    {
        _accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 44.0)];
        _accessoryView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _accessoryView.barTintColor = [UIColor colorWithRed:0.608 green:0.639 blue:0.690 alpha:1.000];
        _accessoryView.tintColor = [UIColor whiteColor];
        _accessoryView.delegate = self;
        
        UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedButton.width = 5.0;
        
        [_accessoryView setItems:@[fixedButton, self.accessoryButton]];
    }
    
    return _accessoryView;
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
    return UIBarPositionAny;
}

#pragma mark - Toggle keyboard

- (void)toggleKeyboard
{
    self.showsKeyboard = !(self.showsKeyboard);
    [self askDelegateAboutBalancedToggleForCompoundTextViewsIfNeeded];
    
    if (self.showsKeyboard) {
        [self becomeFirstResponder];
    } else {
        [self resignFirstResponder];
    }
}

- (void)askDelegateAboutBalancedToggleForCompoundTextViewsIfNeeded
{
    if (self.showsKeyboard && self.delegate != nil && [self.delegate respondsToSelector:@selector(compoundTextViewsForTextView:)])
    {
        NSArray *compoundTextViews = [self.delegate compoundTextViewsForTextView:self];
        [compoundTextViews enumerateObjectsUsingBlock:^(FMINumericTextView *compoundTextView, NSUInteger idx, BOOL *stop) {
            
            if (![compoundTextView isEqual:self] && compoundTextView.showsKeyboard) {
                compoundTextView.showsKeyboard = NO;
            }
            
        }];
    }
}

#pragma mark - Clear text

- (IBAction)clearText:(id)sender
{
    self.text = [self clearedText];
    [self informDelegateAboutClearingText];
}

- (NSString *)clearedText
{
    return ([self.text hasPrefix:@"-"]) ? @"-" : @"";
}

- (void)informDelegateAboutClearingText
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(textViewDidClearText:)]) {
        [self.delegate textViewDidClearText:self];
    }
}

#pragma mark - Invert text

- (IBAction)invertText:(id)sender
{
    self.text = [self invertedText];
    [self informDelegateAboutInvertingText];
}

- (NSString *)invertedText
{
    return ([self.text hasPrefix:@"-"]) ? [self.text substringFromIndex:1] : [NSString stringWithFormat:@"-%@", self.text];
}

- (void)informDelegateAboutInvertingText
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(textViewDidInvertText:)]) {
        [self.delegate textViewDidInvertText:self];
    }
}

#pragma mark - Keyboard notifications

- (BOOL)becomeFirstResponder
{
    [self registerForKeyboardAppearanceNotification];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    self.showsKeyboard = NO;
    return [super resignFirstResponder];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self removeFromKeyboardAppearanceNotitication];
    self.showsKeyboard = NO;
}

- (void)registerForKeyboardAppearanceNotification
{
    if (self.accessoryButtonType != FMINumericTextViewAccessoryButtonTypeNone) {
        [self.notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)removeFromKeyboardAppearanceNotitication
{
    if (self.accessoryButtonType != FMINumericTextViewAccessoryButtonTypeNone) {
        [self.notificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

#pragma mark - Prepare clear button

- (UIBarButtonItem *)accessoryButton
{
    if (!_accessoryButton && self.accessoryButtonType != FMINumericTextViewAccessoryButtonTypeNone) {
        _accessoryButton = (self.accessoryButtonType == FMINumericTextViewAccessoryButtonTypeClear) ? [self clearButton] : [self invertButton];
    }
    
    return _accessoryButton;
}

- (UIBarButtonItem *)clearButton
{
    FMIDurationFormatter *durationFormatter = [[FMIDurationFormatter alloc] init];
    durationFormatter.style = self.durationStyle;
    return [self accessoryButtonWithTitle:[durationFormatter stringFromDuration:[FMIDuration zero]] action:@selector(clearText:)];
}

- (UIBarButtonItem *)invertButton
{
    return [self accessoryButtonWithTitle:@"+/-" action:@selector(invertText:)];
}

- (UIBarButtonItem *)accessoryButtonWithTitle:(NSString *)title action:(SEL)selector
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    return button;
}

@end