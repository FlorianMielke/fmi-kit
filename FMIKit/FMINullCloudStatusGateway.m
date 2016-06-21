#import "FMINullCloudStatusGateway.h"

@implementation FMINullCloudStatusGateway

- (FMICloudStatus)fetchCloudStatus {
    return FMICloudStatusDisabled;
}

- (void)saveCloudStatus:(FMICloudStatus)cloudStatus {

}

@end
