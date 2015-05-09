//
//  Created by Florian Mielke on 09.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import "FMIKitFactory.h"
#import "FMIActivityIndicatorAlertView.h"

@implementation FMIKitFactory

- (id<FMIAlertView>)createActivitiyIndicatorAlertViewWithTitle:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *activityIndicatorView = [UIActivityIndicatorView new];
    FMIActivityIndicatorAlertView *alertView = [[FMIActivityIndicatorAlertView alloc] initWithAlertController:alertController activityIndicatorView:activityIndicatorView];
    alertView.title = title;
    return alertView;
}

@end
