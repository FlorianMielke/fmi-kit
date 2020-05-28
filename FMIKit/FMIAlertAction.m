#import "FMIAlertAction.h"
#import "FMIKitConstants.h"

@implementation FMIAlertAction

+ (UIAlertAction *)okAlertAction {
    return [UIAlertAction actionWithTitle:FMILocalizedStringForKey(@"OK") style:UIAlertActionStyleDefault handler:NULL];
}

@end
