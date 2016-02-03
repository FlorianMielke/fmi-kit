#import <UIKit/UIKit.h>

#import "FMIAlertView.h"

@class FMIDateHelper;

@interface FMIKitFactory : NSObject

+ (FMIDateHelper *)createDateHelper;

- (id <FMIAlertView>)createActivitiyIndicatorAlertViewWithTitle:(NSString *)title;

@end
