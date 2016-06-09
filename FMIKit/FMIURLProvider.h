#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMIURLProvider <NSObject>

- (NSURL *)provideURL;

@end

NS_ASSUME_NONNULL_END