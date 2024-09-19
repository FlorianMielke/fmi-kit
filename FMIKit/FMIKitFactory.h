#import <Foundation/Foundation.h>

@class FMIDateHelper;
@class FMIFileCoordinator;
@class FMIReviewNotificationCoordinator;
@class FMIWhatsNewCoordinator;
@class FMIWhatsNewCoordinator;
@protocol FMIAttachment;
@protocol FMIMessage;
@protocol FMIURLProvider;

NS_ASSUME_NONNULL_BEGIN

@interface FMIKitFactory : NSObject

+ (FMIDateHelper *)createDateHelper;

+ (NSUserDefaults *)createUserDefaults;

+ (FMIFileCoordinator *)createFileCoordinator;

+ (FMIReviewNotificationCoordinator *)createReviewNotificationCoordinatorForAppStoreID:(NSString *)appStoreID;

+ (FMIWhatsNewCoordinator *)createWhatsNewCoordinatorWithURLProvider:(id <FMIURLProvider>)URLProvider;

+ (id <FMIMessage>)createErrorMessageForError:(NSError *)error diagnosticData:(nullable NSString *)diagnosticData bundle:(NSBundle *)bundle;

+ (id <FMIMessage>)createErrorMessageForError:(NSError *)error diagnosticData:(nullable NSString *)diagnosticData bundle:(NSBundle *)bundle emailAddress:(NSString *)emailAddress;

@end

NS_ASSUME_NONNULL_END
