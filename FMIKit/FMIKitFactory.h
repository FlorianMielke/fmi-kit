#import <UIKit/UIKit.h>

@class FMIDateHelper;
@class FMIStore;
@class FMIModifyCloudStatus;
@class FMIFetchCloudStatus;
@class FMIFileCoordinator;
@class FMIReviewNotificationCoordinator;
@class FMIWhatsNewCoordinator;
@class FMIWhatsNewCoordinator;
@protocol FMIAttachment;
@protocol FMIMessage;
@protocol FMIAlertView;
@protocol FMIURLProvider;

@interface FMIKitFactory : NSObject

+ (FMIDateHelper *)createDateHelper;

- (id <FMIAlertView>)createActivityIndicatorAlertViewWithTitle:(NSString *)title;

+ (FMIFetchCloudStatus *)createFetchCloudStatus;

+ (FMIFetchCloudStatus *)createFetchInitialCloudStatus;

+ (FMIModifyCloudStatus *)createModifyCloudStatus;

+ (FMIModifyCloudStatus *)createModifyInitialCloudStatus;

+ (NSUserDefaults *)createUserDefaults;

+ (FMIFileCoordinator *)createFileCoordinator;

+ (FMIStore *)createStore;

+ (FMIReviewNotificationCoordinator *)createReviewNotificationCoordinatorForAppStoreID:(NSString *)appStoreID;

+ (FMIWhatsNewCoordinator *)createWhatsNewCoordinatorWithURLProvider:(id <FMIURLProvider>)URLProvider;

+ (id <FMIMessage>)createErrorMessageForError:(NSError *)error bundle:(NSBundle *)bundle;

@end
