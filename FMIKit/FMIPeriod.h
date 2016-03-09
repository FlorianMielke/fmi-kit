#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIPeriod : NSObject <NSSecureCoding, NSCopying>

@property (readonly, NS_NONATOMIC_IOSONLY) NSDate *startDate;
@property (readonly, NS_NONATOMIC_IOSONLY) NSDate *endDate;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end

NS_ASSUME_NONNULL_END