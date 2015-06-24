//
//  Created by Florian Mielke on 09.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMIAlertView.h"

@interface FMIKitFactory : NSObject

- (id<FMIAlertView>)createActivitiyIndicatorAlertViewWithTitle:(NSString *)title;

@end
