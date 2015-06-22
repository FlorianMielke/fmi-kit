//
//  Created by Florian Mielke on 09.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

@import UIKit;

@protocol FMIAlertView <NSObject>

- (void)presentInViewController:(UIViewController *)viewController;
- (void)dismissWithCompletion:(void (^)(void))completion;

@end
