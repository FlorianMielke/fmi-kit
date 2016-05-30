#import <FMIKit/FMIKit.h>
#import "FMIModifyCloudStatus.h"
#import "FMICloudStatusGateway.h"

@interface FMIModifyCloudStatus ()

@property (NS_NONATOMIC_IOSONLY) id <FMICloudStatusGateway> cloudStatusGateway;

@end

@implementation FMIModifyCloudStatus

- (instancetype)initWithCloudStatusGateway:(id <FMICloudStatusGateway>)cloudStatusGateway {
    self = [super init];
    if (self) {
        self.cloudStatusGateway = cloudStatusGateway;
    }
    return self;
}

- (void)modifyCloudStatus:(FMICloudStatus)newCloudStatus {
    switch (newCloudStatus) {
        case FMICloudStatusEnabled: {
            [self.cloudStatusGateway saveCloudStatus:newCloudStatus];
            break;
        }
        case FMICloudStatusDisabled: {
            [self.cloudStatusGateway saveCloudStatus:newCloudStatus];
            break;
        }
        case FMICloudStatusUnknown:break;
    }
}

@end
