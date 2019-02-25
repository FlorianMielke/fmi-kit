#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@protocol FMIMessage;
@protocol FMIMailerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface FMIMailer : NSObject <MFMailComposeViewControllerDelegate>

- (BOOL)canMail;

- (void)mail:(id<FMIMessage>)message withPresentingViewController:(UIViewController *)viewController mailComposeViewController:(MFMailComposeViewController *)mailComposeViewController delegate:(id<FMIMailerDelegate>)delegate;

@end

@protocol FMIMailerDelegate <NSObject>

- (void)mailerDidFinishSending:(FMIMailer *)mailer;

@end

NS_ASSUME_NONNULL_END
