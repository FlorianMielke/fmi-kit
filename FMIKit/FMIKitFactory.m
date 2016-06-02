#import "FMIKitFactory.h"
#import "FMIActivityIndicatorAlertView.h"
#import "FMIDateHelper.h"
#import "FMIFetchCloudStatus.h"
#import "FMIStore.h"
#import "FMIUserDefaultsCloudStatusGateway.h"
#import "FMIModifyCloudStatus.h"
#import "FMIFileCoordinator.h"
#import "FMIReviewNotificationCoordinator.h"
#import "FMIWhatsNewCoordinator.h"
#import "FMIUbiquitousCloudStatusGateway.h"
#import "FMILogFile.h"
#import "FMIErrorLogFile.h"
#import "FMIMessage.h"
#import "FMIErrorMessage.h"

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
    id <FMICloudStatusGateway> cloudStateGateway = [FMIKitFactory createUserDefaultsCloudStatusGateway];
    return [[FMIFetchCloudStatus alloc] initWithCloudStateGateway:cloudStateGateway];
}

+ (FMIFetchCloudStatus *)createFetchInitialCloudStatus {
    id <FMICloudStatusGateway> cloudStateGateway = [FMIKitFactory createUbiquitousCloudStatusGateway];
    return [[FMIFetchCloudStatus alloc] initWithCloudStateGateway:cloudStateGateway];
}

+ (FMIModifyCloudStatus *)createModifyCloudStatus {
    id <FMICloudStatusGateway> cloudStateGateway = [FMIKitFactory createUserDefaultsCloudStatusGateway];
    return [[FMIModifyCloudStatus alloc] initWithCloudStatusGateway:cloudStateGateway];
}

+ (FMIModifyCloudStatus *)createModifyInitialCloudStatus {
    id <FMICloudStatusGateway> cloudStateGateway = [FMIKitFactory createUbiquitousCloudStatusGateway];
    return [[FMIModifyCloudStatus alloc] initWithCloudStatusGateway:cloudStateGateway];
}

+ (id <FMICloudStatusGateway>)createUbiquitousCloudStatusGateway {
    NSUbiquitousKeyValueStore *keyValueStore = [self createUbiquitousKeyValueStore];
    return [[FMIUbiquitousCloudStatusGateway alloc] initWithKeyValueStore:keyValueStore];
}

+ (NSUbiquitousKeyValueStore *)createUbiquitousKeyValueStore {
    return [NSUbiquitousKeyValueStore defaultStore];
}

+ (id <FMICloudStatusGateway>)createUserDefaultsCloudStatusGateway {
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

+ (FMIWhatsNewCoordinator *)createWhatsNewCoordinatorWithBaseURL:(NSURL *)whatsNewBaseURL {
    NSBundle *bundle = [NSBundle mainBundle];
    NSUserDefaults *userDefaults = [FMIKitFactory createUserDefaults];
    return [[FMIWhatsNewCoordinator alloc] initWithBundle:bundle userDefaults:userDefaults whatsNewBaseURL:whatsNewBaseURL];
}

+ (id <FMIMessage>)createErrorMessageForError:(NSError *)error bundle:(NSBundle *)bundle {
    id <FMILogFile> logFile = [FMIKitFactory createLogFileFromError:error bundle:bundle];
    return [[FMIErrorMessage alloc] initWithLogFile:logFile bundle:bundle];
}

+ (id <FMILogFile>)createLogFileFromError:(NSError *)error bundle:(NSBundle *)bundle {
    return [[FMIErrorLogFile alloc] initWithError:error bundle:bundle];
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
