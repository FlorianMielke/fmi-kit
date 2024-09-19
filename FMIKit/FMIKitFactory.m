#import "FMIKitFactory.h"
#import "FMIDateHelper.h"
#import "FMIReviewNotificationCoordinator.h"
#import "FMIAttachment.h"
#import "FMIErrorLogFile.h"
#import "FMIMessage.h"
#import "FMIErrorMessage.h"

@implementation FMIKitFactory

+ (FMIDateHelper *)createDateHelper {
    return [[FMIDateHelper alloc] init];
}

+ (FMIReviewNotificationCoordinator *)createReviewNotificationCoordinatorForAppStoreID:(NSString *)appStoreID {
    NSUserDefaults *userDefaults = [FMIKitFactory createUserDefaults];
    NSCalendar *calendar = [FMIKitFactory createCalendar];
    return [[FMIReviewNotificationCoordinator alloc] initWithAppStoreID:appStoreID userDefaults:userDefaults calendar:calendar];
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

+ (NSCalendar *)createCalendar {
    return [NSCalendar currentCalendar];
}

@end
