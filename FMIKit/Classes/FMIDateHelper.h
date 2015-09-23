#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIDateHelper : NSObject

+ (NSDate *)dateForCurrentTime;

+ (NSDate *)dateForCurrentTimeWithoutSeconds;

+ (NSDate *)dateWithoutSecondsFromDate:(NSDate *)date;

+ (NSDate *)dateBySettingHour:(NSInteger)hour minute:(NSInteger)minute ofDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone;

+ (NSTimeInterval)timeIntervalFromDateToNow:(NSDate *)date;

+ (NSTimeInterval)timeIntervalFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end

NS_ASSUME_NONNULL_END