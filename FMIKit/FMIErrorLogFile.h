#import "FMIAttachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMIErrorLogFile : NSObject <FMIAttachment>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithError:(NSError *)error diagnosticData:(nullable NSString *)diagnosticData bundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
