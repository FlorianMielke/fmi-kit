#import <UIKit/UIKit.h>
#import "FMIAlertController.h"
#import "FMIAlertAction.h"
#import "FMIKitConstants.h"

@implementation FMIAlertController

+ (UIAlertController *)okAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[FMIAlertAction okAlertAction]];
    return alertController;
}

+ (UIAlertController *)alertControllerForSendingMailFailed {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:FMILocalizedStringForKey(@"alert_controller.sending_mail_failed.title") message:FMILocalizedStringForKey(@"alert_controller.sending_mail_failed.message") preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[FMIAlertAction okAlertAction]];
    return alertController;
}

+ (UIAlertController *)alertControllerForCannotSendMail {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:FMILocalizedStringForKey(@"alert_controller.cannot_send_mail.title") message:FMILocalizedStringForKey(@"alert_controller.cannot_send_mail.message") preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[FMIAlertAction okAlertAction]];
    return alertController;
}

@end