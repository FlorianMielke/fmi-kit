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

- (void)modifyCloudStatus:(FMICloudStatus)newCloudStatus {
    switch (newCloudStatus) {
        case FMICloudStatusEnabled: {
            FMICloudStatus oldCloudStatus = [self.cloudStatusGateway fetchCloudStatus];
            [self.cloudStatusGateway saveCloudStatus:newCloudStatus];
            [self.store migrateLocalStoreToICloudStoreWithOldCloudStatus:oldCloudStatus];
            break;
        }
        case FMICloudStatusDisabled: {
            [self.cloudStatusGateway saveCloudStatus:newCloudStatus];
            [self.store migrateICloudStoreToLocalStore];
            break;
        }
        case FMICloudStatusUnknown:break;
    }
}

@end
