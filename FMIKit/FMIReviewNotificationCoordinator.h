#import <Foundation/Foundation.h>

@interface FMIReviewNotificationCoordinator : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) BOOL shouldShow;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *reviewURL;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *appStoreID;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithAppStoreID:(NSString *)appStoreID userDefaults:(NSUserDefaults *)userDefaults calendar:(NSCalendar *)calendar;

- (void)decline;

- (void)review;

@end
