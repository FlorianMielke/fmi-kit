#import "NSBundle+FMIKit.h"

@implementation NSBundle (FMIKit)

+ (NSBundle *)fmiKitBundle {
    return [NSBundle bundleWithIdentifier:@"com.madefm.FMIKit"];
}

@end
