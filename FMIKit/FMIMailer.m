#import "FMIMailer.h"
#import "FMIMessage.h"
#import "FMIAttachment.h"
#import <MessageUI/MessageUI.h>

@interface FMIMailer () <MFMailComposeViewControllerDelegate, UINavigationControllerDelegate>

@property (weak, nullable, NS_NONATOMIC_IOSONLY) id <FMIMailerDelegate> delegate;
@property (NS_NONATOMIC_IOSONLY) MFMailComposeViewController *mailComposeViewController;

@end

@implementation FMIMailer

- (BOOL)canMail {
  return [MFMailComposeViewController canSendMail];
}

- (void)mail:(id<FMIMessage>)message withPresentingViewController:(UIViewController *)viewController delegate:(nonnull id<FMIMailerDelegate>)delegate {
  if (![self canMail]) {
    return;
  }
  self.delegate = delegate;
  self.mailComposeViewController = [[MFMailComposeViewController alloc] init];
  self.mailComposeViewController.mailComposeDelegate = self;
  [self.mailComposeViewController setToRecipients:message.toRecipients];
  [self.mailComposeViewController setSubject:message.subject];
  [self.mailComposeViewController setMessageBody:message.messageBody isHTML:NO];
  for (id<FMIAttachment> attachment in message.attachments) {
    [self.mailComposeViewController addAttachmentData:attachment.dataRepresentation mimeType:attachment.mimeType fileName:attachment.fileName];
  }
  [viewController presentViewController:self.mailComposeViewController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
  [controller dismissViewControllerAnimated:YES completion:^{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(mailerDidFinishSending:)]) {
      [self.delegate mailerDidFinishSending:self];
    }
  }];
}

@end
