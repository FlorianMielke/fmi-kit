#import "FMIMailer.h"
#import "FMIMessage.h"
#import "FMIAttachment.h"

@interface FMIMailer ()

@property (weak, nullable, NS_NONATOMIC_IOSONLY) id <FMIMailerDelegate> delegate;

@end

@implementation FMIMailer

- (BOOL)canMail {
  return [MFMailComposeViewController canSendMail];
}

- (void)mail:(id<FMIMessage>)message withPresentingViewController:(UIViewController *)viewController mailComposeViewController:(MFMailComposeViewController *)mailComposeViewController delegate:(nonnull id<FMIMailerDelegate>)delegate {
  if (![self canMail]) {
    return;
  }
  self.delegate = delegate;
  mailComposeViewController.mailComposeDelegate = self;
  [mailComposeViewController setToRecipients:message.toRecipients];
  [mailComposeViewController setSubject:message.subject];
  [mailComposeViewController setMessageBody:message.messageBody isHTML:NO];
  for (id<FMIAttachment> attachment in message.attachments) {
    [mailComposeViewController addAttachmentData:attachment.dataRepresentation mimeType:attachment.mimeType fileName:attachment.fileName];
  }
  [viewController presentViewController:mailComposeViewController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
  [controller dismissViewControllerAnimated:YES completion:^{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(mailerDidFinishSending:)]) {
      [self.delegate mailerDidFinishSending:self];
    }
  }];
}

@end
