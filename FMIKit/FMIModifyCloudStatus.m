#import <FMIKit/FMIKit.h>
#import "FMIModifyCloudStatus.h"
#import "FMICloudStatusGateway.h"

@interface FMIModifyCloudStatus ()

@property (NS_NONATOMIC_IOSONLY) id <FMICloudStatusGateway> cloudStatusGateway;
@property (NS_NONATOMIC_IOSONLY) FMIStore *store;

@end

@implementation FMIModifyCloudStatus

- (instancetype)initWithCloudStatusGateway:(id <FMICloudStatusGateway>)cloudStatusGateway store:(FMIStore *)store {
    self = [super init];
    if (self) {
        self.cloudStatusGateway = cloudStatusGateway;
        self.store = store;
    }
    return self;
}

- (void)modifyCloudStatus:(FMICloudStatus)newCloudState {
    switch (newCloudState) {
        case FMICloudStatusEnabled: {
            [self.store migrateLocalStoreToICloudStore];
            [self.cloudStatusGateway saveCloudStatus:newCloudState];
            break;
        }
        case FMICloudStatusDisabled: {
            [self.store migrateICloudStoreToLocalStore];
            [self.cloudStatusGateway saveCloudStatus:newCloudState];
            break;
        }
        case FMICloudStatusUnknown:break;
    }
}

@end
