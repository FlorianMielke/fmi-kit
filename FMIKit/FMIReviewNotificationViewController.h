#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMIReviewNotificationViewControllerDelegate;

@interface FMIReviewNotificationViewController : UIViewController

@property (nullable, weak, NS_NONATOMIC_IOSONLY) id <FMIReviewNotificationViewControllerDelegate> delegate;

- (IBAction)review:(id)sender;

- (IBAction)decline:(nullable id)sender;

@end

@protocol FMIReviewNotificationViewControllerDelegate <NSObject>

- (void)reviewNotificationViewControllerWantsToReview:(FMIReviewNotificationViewController *)viewController;
- (void)reviewNotificationViewControllerWantsToBeClosed:(FMIReviewNotificationViewController *)viewController;

@end

NS_ASSUME_NONNULL_END