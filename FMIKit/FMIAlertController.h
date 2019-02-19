#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIAlertController : NSObject

+ (UIAlertController *)okAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

+ (UIAlertController *)alertControllerForSendingMailFailed;

+ (UIAlertController *)alertControllerForCannotSendMail;

+ (UIAlertController *)alertControllerForError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
