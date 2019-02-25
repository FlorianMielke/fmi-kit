#import <UIKit/UIKit.h>

@class FMIDateHelper;
@class FMICoreDataStore;
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

NS_ASSUME_NONNULL_BEGIN

@interface FMIKitFactory : NSObject

+ (FMIDateHelper *)createDateHelper;

- (id <FMIAlertView>)createActivityIndicatorAlertViewWithTitle:(NSString *)title;

+ (FMIFetchCloudStatus *)createFetchCloudStatus;

+ (FMIFetchCloudStatus *)createFetchInitialCloudStatus;

+ (FMIModifyCloudStatus *)createModifyCloudStatus;

+ (FMIModifyCloudStatus *)createModifyInitialCloudStatus;

+ (NSUserDefaults *)createUserDefaults;

+ (FMIFileCoordinator *)createFileCoordinator;

+ (FMICoreDataStore *)createStore;

+ (FMIReviewNotificationCoordinator *)createReviewNotificationCoordinatorForAppStoreID:(NSString *)appStoreID;

+ (FMIWhatsNewCoordinator *)createWhatsNewCoordinatorWithURLProvider:(id <FMIURLProvider>)URLProvider;

+ (id <FMIMessage>)createErrorMessageForError:(NSError *)error bundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
