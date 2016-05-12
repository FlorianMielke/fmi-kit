#import "FMIKitFactory.h"
#import "FMIActivityIndicatorAlertView.h"
#import "FMIDateHelper.h"
#import "FMIFetchCloudStatus.h"
#import "FMIStore.h"
#import "FMIUserDefaultsCloudStatusGateway.h"
#import "FMIModifyCloudStatus.h"

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

+ (NSUserDefaults *)createUserDefaults {
    return [NSUserDefaults standardUserDefaults];
}

@end
