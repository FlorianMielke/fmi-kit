#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIDateHelper : NSObject

+ (NSDate *)dateForCurrentTimeWithoutSeconds;

+ (NSDate *)dateWithoutSecondsFromDate:(NSDate *)date;

+ (NSDate *)dateBySettingHour:(NSInteger)hour minute:(NSInteger)minute ofDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone;

@end

NS_ASSUME_NONNULL_END