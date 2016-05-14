#import <Foundation/Foundation.h>
#import "FMICloudStatus.h"

@class FMIStore;
@protocol FMICloudStatusGateway;

NS_ASSUME_NONNULL_BEGIN

@interface FMIModifyCloudStatus : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCloudStatusGateway:(id <FMICloudStatusGateway>)cloudStatusGateway store:(FMIStore *)store;

- (void)modifyCloudStatus:(FMICloudStatus)newCloudStatus;

@end

NS_ASSUME_NONNULL_END