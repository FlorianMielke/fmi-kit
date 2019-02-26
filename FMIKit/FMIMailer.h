#import <UIKit/UIKit.h>

@protocol FMIMessage;
@protocol FMIMailerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface FMIMailer : NSObject

- (BOOL)canMail;

- (void)mail:(id<FMIMessage>)message withPresentingViewController:(UIViewController *)viewController delegate:(id<FMIMailerDelegate>)delegate;

@end

@protocol FMIMailerDelegate <NSObject>

- (void)mailerDidFinishSending:(FMIMailer *)mailer;

@end

NS_ASSUME_NONNULL_END
