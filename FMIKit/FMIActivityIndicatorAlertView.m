//
//  Created by Florian Mielke on 09.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import "FMIActivityIndicatorAlertView.h"

@interface FMIActivityIndicatorAlertView ()

@property (NS_NONATOMIC_IOSONLY) UIAlertController *alertController;
@property (NS_NONATOMIC_IOSONLY) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation FMIActivityIndicatorAlertView

- (instancetype)initWithAlertController:(UIAlertController *)alertController activityIndicatorView:(UIActivityIndicatorView *)activitiyIndicatorView {
    if (!alertController || !activitiyIndicatorView || alertController.preferredStyle != UIAlertControllerStyleAlert) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.alertController = alertController;
        self.activityIndicatorView = activitiyIndicatorView;
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

- (void)dismiss {
    [self.alertController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setTitle:(NSString *)title {
    self.alertController.title = title;
}

@end
