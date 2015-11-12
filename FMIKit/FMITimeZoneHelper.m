#import "FMITimeZoneHelper.h"

@implementation FMITimeZoneHelper

+ (NSString *)nameOfDefaultTimeZone {
    return [NSTimeZone defaultTimeZone].name;
}

@end
