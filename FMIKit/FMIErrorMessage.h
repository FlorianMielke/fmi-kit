#import <FMIKit/FMIMessage.h>

@protocol FMIAttachment;

NS_ASSUME_NONNULL_BEGIN

@interface FMIErrorMessage : NSObject <FMIMessage>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithLogFile:(id <FMIAttachment>)logFile bundle:(NSBundle *)bundle;

- (instancetype)initWithLogFile:(id <FMIAttachment>)logFile bundle:(NSBundle *)bundle emailAddress:(NSString *)emailAddress;

@end

NS_ASSUME_NONNULL_END
