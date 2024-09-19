#import <Foundation/Foundation.h>

@class FMIDateHelper;
@class FMIReviewNotificationCoordinator;

NS_ASSUME_NONNULL_BEGIN

@interface FMIKitFactory : NSObject

+ (FMIDateHelper *)createDateHelper;

+ (NSUserDefaults *)createUserDefaults;

+ (FMIReviewNotificationCoordinator *)createReviewNotificationCoordinatorForAppStoreID:(NSString *)appStoreID;

@end

NS_ASSUME_NONNULL_END
