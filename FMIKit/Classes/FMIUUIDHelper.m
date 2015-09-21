#import "FMIUUIDHelper.h"

@implementation FMIUUIDHelper

- (NSString *)generateUUIDString {
    return [NSUUID UUID].UUIDString;
}

@end