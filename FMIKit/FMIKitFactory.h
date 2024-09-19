#import <Foundation/Foundation.h>

@class FMIDateHelper;
@class FMIFileCoordinator;
@class FMIReviewNotificationCoordinator;

NS_ASSUME_NONNULL_BEGIN

@interface FMIKitFactory : NSObject

+ (FMIDateHelper *)createDateHelper;

+ (NSUserDefaults *)createUserDefaults;

+ (FMIFileCoordinator *)createFileCoordinator;

+ (FMIReviewNotificationCoordinator *)createReviewNotificationCoordinatorForAppStoreID:(NSString *)appStoreID;

@end

NS_ASSUME_NONNULL_END
