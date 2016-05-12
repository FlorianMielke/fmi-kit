#import "FMICloudStatusGateway.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMIUserDefaultsCloudStatusGateway : NSObject <FMICloudStatusGateway>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults;

@end

NS_ASSUME_NONNULL_END