#import "FMIKitFactory.h"
#import "FMIActivityIndicatorAlertView.h"
#import "FMIDateHelper.h"
#import "FMIFileCoordinator.h"
#import "FMIReviewNotificationCoordinator.h"
#import "FMIWhatsNewCoordinator.h"
#import "FMIAttachment.h"
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

+ (FMIReviewNotificationCoordinator *)createReviewNotificationCoordinatorForAppStoreID:(NSString *)appStoreID {
    NSUserDefaults *userDefaults = [FMIKitFactory createUserDefaults];
    NSCalendar *calendar = [FMIKitFactory createCalendar];
    return [[FMIReviewNotificationCoordinator alloc] initWithAppStoreID:appStoreID userDefaults:userDefaults calendar:calendar];
}

+ (FMIWhatsNewCoordinator *)createWhatsNewCoordinatorWithURLProvider:(id <FMIURLProvider>)URLProvider {
    NSBundle *bundle = [NSBundle mainBundle];
    NSUserDefaults *userDefaults = [FMIKitFactory createUserDefaults];
    return [[FMIWhatsNewCoordinator alloc] initWithBundle:bundle userDefaults:userDefaults URLProvider:URLProvider];
}

+ (id <FMIMessage>)createErrorMessageForError:(NSError *)error diagnosticData:(nullable NSString *)diagnosticData bundle:(NSBundle *)bundle {
    id <FMIAttachment> logFile = [FMIKitFactory createLogFileFromError:error diagnosticData:diagnosticData bundle:bundle];
    return [[FMIErrorMessage alloc] initWithLogFile:logFile bundle:bundle];
}

+ (id <FMIMessage>)createErrorMessageForError:(NSError *)error diagnosticData:(nullable NSString *)diagnosticData bundle:(NSBundle *)bundle emailAddress:(NSString *)emailAddress {
    id <FMIAttachment> logFile = [FMIKitFactory createLogFileFromError:error diagnosticData:diagnosticData bundle:bundle];
    return [[FMIErrorMessage alloc] initWithLogFile:logFile bundle:bundle emailAddress:emailAddress];
}

+ (id <FMIAttachment>)createLogFileFromError:(NSError *)error diagnosticData:(nullable NSString *)diagnosticData bundle:(NSBundle *)bundle {
    return [[FMIErrorLogFile alloc] initWithError:error diagnosticData:diagnosticData bundle:bundle];
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
