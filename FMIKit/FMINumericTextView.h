//
//  FMINumericTextView.h
//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import UIKit;
#import "FMIDurationFormatter.h"

@class FMINumericTextView;

@protocol FMINumericTextViewDelegate <NSObject, UITextViewDelegate>

@optional

/**
 *	Ask the delegate return a list of compound text view to balance toggle call with.
 *	@param	textView	The text view requesting this information.
 *	@return	A list of text view to balance the toggle call with.
 */
- (NSArray *)compoundTextViewsForTextView:(FMINumericTextView *)textView;

/**
 *	Informs the delegate that the text view has cleared it's text.
 *	@param	textView	The text view in which the text has been cleared.
 */
- (void)textViewDidClearText:(FMINumericTextView *)textView;

/**
 *	Informs the delegate that the text view has inverted it's text.
 *	@param	textView	The text view in which the text has been inverted.
 */
- (void)textViewDidInvertText:(FMINumericTextView *)textView;

@end

typedef NS_ENUM (NSInteger, FMINumericTextViewAccessoryButtonType) {
	FMINumericTextViewAccessoryButtonTypeNone = 0,
	FMINumericTextViewAccessoryButtonTypeClear = 1,
	FMINumericTextViewAccessoryButtonTypeInvert = 2
};

/**
 *	The FMINumericTextView class extends UITextView.
 */
@interface FMINumericTextView : UITextView

/**
 *	The receiver’s accessory button.
 */
@property (nonatomic, strong, readonly) UIBarButtonItem *accessoryButton;

/**
 *	The receiver’s delegate.
 *  @see FMINumericTextViewDelegate.
 */
@property (nonatomic, weak) id <FMINumericTextViewDelegate> delegate;

/**
 *	The duration style of the receiver.
 */
@property (nonatomic, assign) FMIDurationFormatterStyle durationStyle;

/**
 * The assigned button type.
 */
@property (nonatomic, assign, readonly) FMINumericTextViewAccessoryButtonType accessoryButtonType;

/**
 *	A Boolean that indicates whether the keyboard is shown or not.
 */
@property (nonatomic, assign, readonly) BOOL showsKeyboard;

/**
 *	Returns a new FMINumericTextView object initialized with a accessory button type.
 * @param accessoryButtonType The accessory button type to use.
 * @return A new FMINumericTextView object.
 */
- (instancetype)initWithAccessoryButtonType:(FMINumericTextViewAccessoryButtonType)accessoryButtonType;

/**
 * Returns a new FMINumericTextView object initialized with a given parameter.
 * @param accessoryButtonType The accessory button type to use.
 * @param notificationCenter  The notification center to use for keyboard appearance notification.
 * @return A new FMINumericTextView object.
 */
- (instancetype)initWithAccessoryButtonType:(FMINumericTextViewAccessoryButtonType)accessoryButtonType notificationCenter:(NSNotificationCenter *)notificationCenter;

/**
 * Toggles the text view as first responder.
 */
- (void)toggleKeyboard;

@end
