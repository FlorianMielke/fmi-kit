#import "FMIReviewNotificationCoordinator.h"

NSString *const FMIReviewNotificationHasDeclinedKey = @"FMIReviewNotificationHasDeclinedKey";
NSString *const FMIReviewNotificationDateOfLastReviewKey = @"FMIReviewNotificationDateOfLastReviewKey";

@interface FMIReviewNotificationCoordinator ()

@property (NS_NONATOMIC_IOSONLY) NSUserDefaults *userDefaults;
@property (NS_NONATOMIC_IOSONLY) NSCalendar *calendar;
@property (copy, NS_NONATOMIC_IOSONLY) NSString *appStoreID;

@end

@implementation FMIReviewNotificationCoordinator

- (instancetype)initWithAppStoreID:(NSString *)appStoreID userDefaults:(NSUserDefaults *)userDefaults calendar:(NSCalendar *)calendar {
    self = [super init];
    if (self) {
        self.userDefaults = userDefaults;
        self.calendar = calendar;
        self.appStoreID = appStoreID;
    }
    return self;
}

- (BOOL)shouldShow {
    NSNumber *hasDeclined = [self.userDefaults objectForKey:FMIReviewNotificationHasDeclinedKey];
    if (hasDeclined && hasDeclined.boolValue) {
        return NO;
    }
    NSDate *dateOfLastReview = [self.userDefaults objectForKey:FMIReviewNotificationDateOfLastReviewKey];
    if (dateOfLastReview) {
        NSDateComponents *lastReviewDateComponents = [self.calendar components:NSCalendarUnitMonth fromDate:dateOfLastReview toDate:[NSDate date] options:0];
        return (lastReviewDateComponents.month > 3);
    }
    return YES;
}

- (void)decline {
    [self.userDefaults setObject:@YES forKey:FMIReviewNotificationHasDeclinedKey];
    [self.userDefaults synchronize];
}

- (void)review {
    [self.userDefaults setObject:[NSDate date] forKey:FMIReviewNotificationDateOfLastReviewKey];
    [self.userDefaults synchronize];
}

- (NSURL *)reviewURL {
    NSString *appStoreReviewFormat = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8";
    NSString *appStoreReviewPath = [NSString stringWithFormat:appStoreReviewFormat, self.appStoreID];
    return [NSURL URLWithString:appStoreReviewPath];
}

@end
