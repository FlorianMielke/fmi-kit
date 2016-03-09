#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIPeriod : NSObject <NSSecureCoding, NSCopying>

@property (readonly, NS_NONATOMIC_IOSONLY) BOOL isAllDay;
@property (readonly, NS_NONATOMIC_IOSONLY) NSDate *startDate;
@property (readonly, NS_NONATOMIC_IOSONLY) NSDate *endDate;
@property (readonly, NS_NONATOMIC_IOSONLY) NSTimeZone *timeZone;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate inTimeZone:(NSTimeZone *)timeZone isAllDay:(BOOL)isAllDay;

@end

NS_ASSUME_NONNULL_END