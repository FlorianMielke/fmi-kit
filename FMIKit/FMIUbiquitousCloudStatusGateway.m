#import "FMIUbiquitousCloudStatusGateway.h"

NSString *const FMIUbiquitousCloudStateGatewayCloudStatusKey = @"FMIUbiquitousCloudStateGatewayCloudStatusKey";

@interface FMIUbiquitousCloudStatusGateway ()

@property (NS_NONATOMIC_IOSONLY) NSUbiquitousKeyValueStore *keyValueStore;

@end

@implementation FMIUbiquitousCloudStatusGateway

- (instancetype)initWithKeyValueStore:(NSUbiquitousKeyValueStore *)keyValueStore {
    self = [super init];
    if (self) {
        self.keyValueStore = keyValueStore;
    }
    return self;
}

- (FMICloudStatus)fetchCloudStatus {
    NSNumber *boxedStatus = [self.keyValueStore objectForKey:FMIUbiquitousCloudStateGatewayCloudStatusKey];
    if (!boxedStatus) {
        return FMICloudStatusUnknown;
    }
    return (FMICloudStatus) boxedStatus.integerValue;
}

- (void)saveCloudStatus:(FMICloudStatus)cloudStatus {
    [self.keyValueStore setObject:@(cloudStatus) forKey:FMIUbiquitousCloudStateGatewayCloudStatusKey];
    [self.keyValueStore synchronize];
}

@end
