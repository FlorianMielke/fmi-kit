#import "FMIKitFactory.h"
#import "FMIActivityIndicatorAlertView.h"
#import "FMIDateHelper.h"
#import "FMIFetchCloudStatus.h"
#import "FMIStore.h"
#import "FMIUserDefaultsCloudStatusGateway.h"
#import "FMIModifyCloudStatus.h"
#import "FMIFileCoordinator.h"
#import "FMIReviewNotificationCoordinator.h"

@implementation FMIKitFactory

- (id <FMIAlertView>)createActivityIndicatorAlertViewWithTitle:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *activityIndicatorView = [UIActivityIndicatorView new];
    FMIActivityIndicatorAlertView *alertView = [[FMIActivityIndicatorAlertView alloc] initWithAlertController:alertController activityIndicatorView:activityIndicatorView];
    alertView.title = title;
    return alertView;
}

+ (FMIDateHelper *)createDateHelper {
    return [[FMIDateHelper alloc] init];
}

+ (FMIFetchCloudStatus *)createFetchCloudStatus {
    id <FMICloudStatusGateway> cloudStateGateway = [FMIKitFactory createCloudStatusGateway];
    return [[FMIFetchCloudStatus alloc] initWithCloudStateGateway:cloudStateGateway];
}

+ (FMIModifyCloudStatus *)createModifyCloudStatus {
    id <FMICloudStatusGateway> cloudStateGateway = [FMIKitFactory createCloudStatusGateway];
    FMIStore *store = [FMIKitFactory createStore];
    return [[FMIModifyCloudStatus alloc] initWithCloudStatusGateway:cloudStateGateway store:store];
}

+ (id <FMICloudStatusGateway>)createCloudStatusGateway {
    NSUserDefaults *userDefaults = [FMIKitFactory createUserDefaults];
    return [[FMIUserDefaultsCloudStatusGateway alloc] initWithUserDefaults:userDefaults];
}

+ (FMIStore *)createStore {
    return [FMIStore sharedStore];
}

+ (FMIReviewNotificationCoordinator *)createReviewNotificationCoordinatorForAppStoreID:(NSString *)appStoreID {
    NSUserDefaults *userDefaults = [FMIKitFactory createUserDefaults];
    NSCalendar *calendar = [FMIKitFactory createCalendar];
    return [[FMIReviewNotificationCoordinator alloc] initWithAppStoreID:appStoreID userDefaults:userDefaults calendar:calendar];
}

+ (NSUserDefaults *)createUserDefaults {
    return [NSUserDefaults standardUserDefaults];
}

+ (FMIFileCoordinator *)createFileCoordinator {
    return [[FMIFileCoordinator alloc] init];
}

+ (NSCalendar *)createCalendar {
    return [NSCalendar currentCalendar];
}

@end
