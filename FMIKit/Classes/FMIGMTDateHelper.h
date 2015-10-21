#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIGMTDateHelper : NSObject

+ (BOOL)isDateInToday:(NSDate *)date;

+ (NSDate *)dateForNoonOfTodayInGMT;

+ (NSDate *)dateForNoonOfDateInGMT:(NSDate *)date;

+ (NSDate *)dateForNoonOfDayInGMTFromDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone;

+ (NSInteger)weekdayOfDateInGMT:(NSDate *)date;

+ (NSUInteger)weekdayIndexOfDateInGMT:(NSDate *)date;

+ (NSDateComponents *)timeComponentsOfDateInGMT:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END