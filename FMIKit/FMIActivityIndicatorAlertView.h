//
//  Created by Florian Mielke on 09.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

@import UIKit;
#import "FMIAlertView.h"

@interface FMIActivityIndicatorAlertView : NSObject <FMIAlertView>

@property (copy, NS_NONATOMIC_IOSONLY) NSString *title;

- (instancetype)initWithAlertController:(UIAlertController *)alertController activityIndicatorView:(UIActivityIndicatorView *)activitiyIndicatorView;

@end
