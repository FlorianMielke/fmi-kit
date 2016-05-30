#import "FMICloudStatusGateway.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMIUbiquitousCloudStatusGateway : NSObject <FMICloudStatusGateway>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithKeyValueStore:(NSUbiquitousKeyValueStore *)keyValueStore;

@end

NS_ASSUME_NONNULL_END