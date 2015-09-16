#import "WKTUUIDHelper.h"

@implementation WKTUUIDHelper

- (NSString *)generateUUIDString {
    return [NSUUID UUID].UUIDString;
}

@end