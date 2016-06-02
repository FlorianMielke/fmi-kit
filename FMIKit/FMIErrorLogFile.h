#import "FMILogFile.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMIErrorLogFile : NSObject <FMILogFile>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithError:(NSError *)error bundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END