#import "FMIReviewNotificationViewController.h"

@implementation FMIReviewNotificationViewController

- (IBAction)review:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(reviewNotificationViewControllerWantsToReview:)]) {
        [self.delegate reviewNotificationViewControllerWantsToReview:self];
    }
}

- (IBAction)decline:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(reviewNotificationViewControllerWantsToBeClosed:)]) {
        [self.delegate reviewNotificationViewControllerWantsToBeClosed:self];
    }
}

@end
