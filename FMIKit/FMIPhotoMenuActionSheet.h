//
//  Created by Florian Mielke on 09.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

@import UIKit;

@class FMIPhotoMenuActionSheet;

@protocol FMIPhotoMenuActionSheetDelegate <NSObject>

- (void)photoMenuActionSheetDelegateDidChooseCamera:(FMIPhotoMenuActionSheet *)actionSheet;

@end

@interface FMIPhotoMenuActionSheet : NSObject

- (instancetype)initWithAlertController:(UIAlertController *)alertController delegate:(id<FMIPhotoMenuActionSheetDelegate>)delegate;

- (void)presentInViewController:(UIViewController *)viewController;
- (void)dismiss;

@end
