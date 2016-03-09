#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIYear : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSNumber *value;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithValue:(NSNumber *)value;

@end

NS_ASSUME_NONNULL_END