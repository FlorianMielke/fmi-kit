#import "FMIUserDefaultsCloudStatusGateway.h"

NSString *const FMIUserDefaultsCloudStateGatewayCloudStatusKey = @"FMIUserDefaultsCloudStateGatewayCloudStatusKey";

@interface FMIUserDefaultsCloudStatusGateway ()

@property (NS_NONATOMIC_IOSONLY) NSUserDefaults *userDefaults;

@end

@implementation FMIUserDefaultsCloudStatusGateway

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults {
    self = [super init];
    if (self) {
        self.userDefaults = userDefaults;
    }
    return self;
}

- (FMICloudStatus)findCloudStatus {
    return (FMICloudStatus) [self.userDefaults integerForKey:FMIUserDefaultsCloudStateGatewayCloudStatusKey];
}

- (void)saveCloudStatus:(FMICloudStatus)cloudStatus {
    [self.userDefaults setInteger:cloudStatus forKey:FMIUserDefaultsCloudStateGatewayCloudStatusKey];
    [self.userDefaults synchronize];
}

@end
