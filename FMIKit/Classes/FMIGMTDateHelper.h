#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIGMTDateHelper : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSCalendar *gmtCalendar;

- (NSDate *)dateForNoonOfTodayInGMT;

- (NSDate *)dateForNoonOfDateInGMT:(NSDate *)date;

- (NSDate *)dateForNoonOfDayInGMTFromDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone;

- (NSDate *)dateForCurrentTimeWithoutSeconds;

- (NSDate *)dateWithoutSecondsFromDate:(NSDate *)date;

- (NSString *)nameOfDefaultTimeZone;

- (NSInteger)weekdayOfDateInGMT:(NSDate *)date;

- (NSUInteger)weekdayIndexOfDateInGMT:(NSDate *)date;

- (NSDateComponents *)timeComponentsOfDateInGMT:(NSDate *)date;

- (NSDate *)dateBySettingHour:(NSInteger)hour minute:(NSInteger)minute ofDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone;

@end

NS_ASSUME_NONNULL_END