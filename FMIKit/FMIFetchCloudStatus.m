#import "FMIFetchCloudStatus.h"
#import "FMICloudStatusGateway.h"

@interface FMIFetchCloudStatus ()

@property (NS_NONATOMIC_IOSONLY) id <FMICloudStatusGateway> cloudStateGateway;

@end

@implementation FMIFetchCloudStatus

- (instancetype)initWithCloudStateGateway:(id <FMICloudStatusGateway>)cloudStateGateway {
    self = [super init];
    if (self) {
        self.cloudStateGateway = cloudStateGateway;
    }
    return self;
}

- (FMICloudStatus)fetchCloudStatus {
    return [self.cloudStateGateway fetchCloudStatus];
}

- (BOOL)isCloudStatusEnabled {
    return [self fetchCloudStatus] == FMICloudStatusEnabled;
}

@end
