#import <Foundation/Foundation.h>
#import "FMICloudStatus.h"

@protocol FMICloudStatusGateway;

NS_ASSUME_NONNULL_BEGIN

@interface FMIFetchCloudStatus : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCloudStateGateway:(id <FMICloudStatusGateway>)cloudStateGateway;

- (FMICloudStatus)fetchCloudStatus;

@end

NS_ASSUME_NONNULL_END