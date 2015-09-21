#import "FMIDateHelperGMT.h"

@interface FMIDateHelperGMT ()

@property (NS_NONATOMIC_IOSONLY) NSCalendar *gmtCalendar;

@end

@implementation FMIDateHelperGMT

- (instancetype)init {
    self = [super init];
    if (self) {
        self.gmtCalendar = [NSCalendar currentCalendar];
        self.gmtCalendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    }
    return self;
}

- (NSDate *)dateForNoonOfTodayInGMT {
    return [self dateForNoonOfDateInGMT:[NSDate date]];
}

- (NSDate *)dateForNoonOfDateInGMT:(NSDate *)date {
    NSDateComponents *dateComponents = [self.gmtCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    dateComponents.hour = 12;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    return [self.gmtCalendar dateFromComponents:dateComponents];
}

- (NSDate *)dateForCurrentTimeWithoutSeconds {
    return [self dateWithoutSecondsFromDate:[NSDate date]];
}

- (NSDate *)dateWithoutSecondsFromDate:(NSDate *)date {
    NSDateComponents *dateComponents = [self.gmtCalendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    dateComponents.second = 0;
    return [self.gmtCalendar dateFromComponents:dateComponents];
}

- (NSString *)nameOfDefaultTimeZone {
    return [NSTimeZone defaultTimeZone].name;
}

- (NSDate *)dateForNoonOfDayInGMTFromDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone {
    NSDateComponents *dayComponents = [self.gmtCalendar componentsInTimeZone:timeZone fromDate:date];
    NSDateComponents *noonOfDateComponents = [[NSDateComponents alloc] init];
    noonOfDateComponents.year = dayComponents.year;
    noonOfDateComponents.month = dayComponents.month;
    noonOfDateComponents.day = dayComponents.day;
    noonOfDateComponents.hour = 12;
    noonOfDateComponents.minute = 0;
    noonOfDateComponents.second = 0;
    return [self.gmtCalendar dateFromComponents:noonOfDateComponents];
}

- (NSInteger)weekdayOfDateInGMT:(NSDate *)date {
    NSDateComponents *dateComponents = [self.gmtCalendar components:NSCalendarUnitWeekday fromDate:date];
    return dateComponents.weekday;
}

- (NSUInteger)weekdayIndexOfDateInGMT:(NSDate *)date {
    return (NSUInteger) (([self weekdayOfDateInGMT:date] - 1));
}

- (NSDateComponents *)timeComponentsOfDateInGMT:(NSDate *)date {
    return [self.gmtCalendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
}

- (NSDate *)dateBySettingHour:(NSInteger)hour minute:(NSInteger)minute ofDate:(NSDate *)date inTimeZone:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = timeZone;
    return [calendar dateBySettingHour:hour minute:minute second:0 ofDate:date options:0];
}

@end