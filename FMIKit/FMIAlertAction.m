#import "FMIAlertAction.h"
#import "FMIKitConstants.h"

@implementation FMIAlertAction

+ (UIAlertAction *)okAlertAction {
    return [UIAlertAction actionWithTitle:FMILocalizedStringForKey(@"alert_action.ok_action.title") style:UIAlertActionStyleDefault handler:NULL];
}

@end