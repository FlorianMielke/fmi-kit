#import "FMIMessage.h"

@protocol FMILogFile;

NS_ASSUME_NONNULL_BEGIN

@interface FMIErrorMessage : NSObject <FMIMessage>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithLogFile:(id <FMILogFile>)logFile bundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END