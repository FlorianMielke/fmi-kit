#import <Foundation/Foundation.h>
#import "FMICloudStatus.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FMICloudStatusGateway <NSObject>

- (FMICloudStatus)fetchCloudStatus;

- (void)saveCloudStatus:(FMICloudStatus)cloudStatus;

@end

NS_ASSUME_NONNULL_END