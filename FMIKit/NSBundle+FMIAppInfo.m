#import "NSBundle+FMIAppInfo.h"

@implementation NSBundle (FMIAppInfo)

- (NSString *)fmi_appName {
    return self.infoDictionary[@"CFBundleDisplayName"];
}

- (NSString *)fmi_versionNumber {
    return self.infoDictionary[@"CFBundleShortVersionString"];
}

- (NSString *)fmi_buildNumber {
    return self.infoDictionary[@"CFBundleVersion"];
}

- (NSString *)fmi_presentableVersionNumber {
    return [self.fmi_versionNumber stringByAppendingFormat:@" (%@)", self.fmi_buildNumber];
}

@end
