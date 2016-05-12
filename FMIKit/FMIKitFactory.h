#import <UIKit/UIKit.h>

@class FMIDateHelper;
@class FMIStore;
@class FMIModifyCloudStatus;
@class FMIFetchCloudStatus;
@protocol FMIAlertView;

@interface FMIKitFactory : NSObject

+ (FMIDateHelper *)createDateHelper;

- (id <FMIAlertView>)createActivityIndicatorAlertViewWithTitle:(NSString *)title;

+ (FMIFetchCloudStatus *)createFetchCloudStatus;

+ (FMIModifyCloudStatus *)createModifyCloudStatus;

+ (NSUserDefaults *)createUserDefaults;

@end
