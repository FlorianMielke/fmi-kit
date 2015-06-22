//
//  Created by Florian Mielke on 09.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import "FMIPhotoMenuActionSheet.h"

@interface FMIPhotoMenuActionSheet ()

@property (weak, NS_NONATOMIC_IOSONLY) id<FMIPhotoMenuActionSheetDelegate> delegate;
@property (NS_NONATOMIC_IOSONLY) UIAlertController *alertController;

@end

@implementation FMIPhotoMenuActionSheet

- (instancetype)initWithAlertController:(UIAlertController *)alertController delegate:(id<FMIPhotoMenuActionSheetDelegate>)delegate {
    if (!alertController || alertController.preferredStyle != UIAlertControllerStyleActionSheet) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.alertController = alertController;
    }
    return self;
}

- (void)presentInViewController:(UIViewController *)viewController {
    NSParameterAssert(viewController != nil);
    [viewController presentViewController:self.alertController animated:YES completion:nil];
}

- (void)dismiss {
    [self.alertController dismissViewControllerAnimated:YES completion:nil];
}

@end
