#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMActionSheet : NSObject

- (void)presentWithTitle:(NSString *)title style:(UIAlertActionStyle)style fromBarButtonItem:(UIBarButtonItem *)fromBarButtonItem popoverArrowDirectionDown:(UIPopoverArrowDirection)popoverArrowDirection viewController:(UIViewController *)viewController actionHandler:(void (^)(UIAlertAction *))actionHandler;

@end

NS_ASSUME_NONNULL_END