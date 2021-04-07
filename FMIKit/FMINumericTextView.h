#import <UIKit/UIKit.h>
#import <FMIKit/FMIDurationFormatter.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, FMINumericTextViewAccessoryButtonType) {
	FMINumericTextViewAccessoryButtonTypeNone = 0,
	FMINumericTextViewAccessoryButtonTypeClear = 1,
	FMINumericTextViewAccessoryButtonTypeInvert = 2
};

@class FMINumericTextView;

@protocol FMINumericTextViewDelegate <NSObject, UITextViewDelegate>

@optional

- (NSArray *)compoundTextViewsForTextView:(FMINumericTextView *)textView;
- (void)textViewDidClearText:(FMINumericTextView *)textView;
- (void)textViewDidInvertText:(FMINumericTextView *)textView;

@end


@interface FMINumericTextView : UITextView

@property (nullable, readonly, NS_NONATOMIC_IOSONLY) UIButton *accessoryButton;
@property (nullable, weak, NS_NONATOMIC_IOSONLY) id <FMINumericTextViewDelegate> delegate;
@property (NS_NONATOMIC_IOSONLY) FMIDurationFormatterStyle durationStyle;
@property (readonly, NS_NONATOMIC_IOSONLY) FMINumericTextViewAccessoryButtonType accessoryButtonType;
@property (readonly, NS_NONATOMIC_IOSONLY) BOOL showsKeyboard;

- (instancetype)initWithAccessoryButtonType:(FMINumericTextViewAccessoryButtonType)accessoryButtonType buttonTintColor:(UIColor *)buttonTintColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor;

- (instancetype)initWithAccessoryButtonType:(FMINumericTextViewAccessoryButtonType)accessoryButtonType buttonTintColor:(UIColor *)buttonTintColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor notificationCenter:(NSNotificationCenter *)notificationCenter;

- (void)toggleKeyboard;

@end

NS_ASSUME_NONNULL_END
