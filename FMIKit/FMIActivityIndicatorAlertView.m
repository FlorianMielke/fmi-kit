//
//  Created by Florian Mielke on 09.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import "FMIActivityIndicatorAlertView.h"

@interface FMIActivityIndicatorAlertView ()

@property(NS_NONATOMIC_IOSONLY) UIAlertController *alertController;
@property(NS_NONATOMIC_IOSONLY) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation FMIActivityIndicatorAlertView

- (instancetype)initWithAlertController:(UIAlertController *)alertController activityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView {
    if (!alertController || !activityIndicatorView || alertController.preferredStyle != UIAlertControllerStyleAlert) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.alertController = alertController;
        self.activityIndicatorView = activityIndicatorView;
    }
    return self;
}

- (void)presentInViewController:(UIViewController *)viewController {
    NSParameterAssert(viewController != nil);
    if (!self.activityIndicatorView.superview) {
        [self.alertController.view addSubview:self.activityIndicatorView];
    }
    [viewController presentViewController:self.alertController animated:YES completion:nil];
}

- (void)dismissWithCompletion:(void (^)(void))completion {
    [self.alertController dismissViewControllerAnimated:YES completion:completion];
}

- (void)setTitle:(NSString *)title {
    self.alertController.title = title;
}

- (NSString *)title {
    return self.alertController.title;
}

@end
