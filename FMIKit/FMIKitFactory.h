#import <UIKit/UIKit.h>

@class FMIDateHelper;
@class FMIStore;
@class FMIModifyCloudStatus;
@class FMIFetchCloudStatus;
@class FMIFileCoordinator;
@protocol FMIAlertView;
@class FMIReviewNotificationCoordinator;
@class FMIWhatsNewCoordinator;
@class FMIWhatsNewCoordinator;

@interface FMIKitFactory : NSObject

+ (FMIDateHelper *)createDateHelper;

- (id <FMIAlertView>)createActivityIndicatorAlertViewWithTitle:(NSString *)title;

+ (FMIFetchCloudStatus *)createFetchCloudStatus;

+ (FMIModifyCloudStatus *)createModifyCloudStatus;

+ (NSUserDefaults *)createUserDefaults;

+ (FMIFileCoordinator *)createFileCoordinator;

+ (FMIStore *)createStore;

+ (FMIReviewNotificationCoordinator *)createReviewNotificationCoordinatorForAppStoreID:(NSString *)appStoreID;

+ (FMIWhatsNewCoordinator *)createWhatsNewCoordinatorWithBaseURL:(NSURL *)whatsNewBaseURL;

@end
