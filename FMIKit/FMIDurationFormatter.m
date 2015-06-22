//
//  FMIDurationFormatter.m
//
//  Created by Florian Mielke on 09.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIDurationFormatter.h"
#import "FMIDuration.h"

static NSString *const FMIDurationFormatterFormatForEditingString = @"%.0f";
static NSString *const FMIDurationFormatterFormatWithNumericPrefixForPositiveDuration = @"%@";
static NSString *const FMIDurationFormatterFormatWithNumericPrefixForNegativeDuration = @"-%@";

@interface FMIDurationFormatter ()

@property (NS_NONATOMIC_IOSONLY) NSNumberFormatter *numberFormatter;

@end

@implementation FMIDurationFormatter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.style = FMIDurationFormatterStyleTime;
        self.locale = [NSLocale autoupdatingCurrentLocale];
        self.numberFormatter = [NSNumberFormatter new];
        [self.numberFormatter setLocale:self.locale];
        [self.numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [self.numberFormatter setMaximumFractionDigits:2];
        [self.numberFormatter setMinimumFractionDigits:2];
    }
    return self;
}

#define k60Minutes 3600
#define k60Seconds 60
#define k1HourFromString 100

- (FMIDuration *)durationFromString:(NSString *)string {
    FMIDuration *duration;
    [self getObjectValue:&duration forString:string errorDescription:NULL];
    return duration;
}

- (BOOL)getObjectValue:(__autoreleasing id *)obj forString:(NSString *)string errorDescription:(NSString *__autoreleasing *)error {
    BOOL returnValue = NO;
    NSTimeInterval timeInterval = 0;
    if (string != nil && ![string isEqualToString:@""]) {
        NSScanner *scanner = [NSScanner scannerWithString:string];
        double stringDuration = [self stringDurationFromString:string scanner:scanner];
        if ([self isDurationLessThanAnHour:stringDuration]) {
            timeInterval = [self timeIntervalFromMinutes:stringDuration];
        } else {
            timeInterval = [self timeIntervalFromStringDuration:stringDuration];
            if ((stringDuration < 0)) {
                timeInterval *= (-1);
            }
        }
    }
    returnValue = YES;
    if (obj) {
        *obj = [FMIDuration durationWithTimeInterval:timeInterval];
    }
    return returnValue;
}

- (BOOL)isValidDurationString:(NSScanner *)scanner {
    return [scanner scanDouble:NULL];
}

- (double)stringDurationFromString:(NSString *)string scanner:(NSScanner *)scanner {
    double stringDuration;
    [scanner scanDouble:&stringDuration];
    return stringDuration;
}

- (NSTimeInterval)timeIntervalFromStringDuration:(double)stringDuration {
    double time = fabs(stringDuration) / 100;
    double hours;
    double minutes = round(modf(time, &hours) * 100);
    return [self timeIntervalFromHours:hours] + [self timeIntervalFromMinutes:minutes];
}

- (NSTimeInterval)timeIntervalFromMinutes:(double)minutes {
    return ([self isTimeStyle]) ? (minutes * k60Seconds) : (round(minutes / 100 * k60Seconds) * k60Seconds);
}

- (NSTimeInterval)timeIntervalFromHours:(double)hours {
    return (hours * k60Minutes);
}

- (BOOL)isDurationLessThanAnHour:(double)duration {
    return (fabs(duration) < k1HourFromString);
}

- (NSString *)stringFromDuration:(FMIDuration *)duration {
    return [self stringForObjectValue:duration];
}

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[FMIDuration class]]) {
        return nil;
    }
    FMIDuration *duration = (FMIDuration *)anObject;
    NSString *formattedDuration = nil;
    switch ([self style]) {
        case FMIDurationFormatterStyleTime: {
            formattedDuration = [NSString stringWithFormat:@"%ld:%02ld", (long)[duration hours], (long)[duration minutes]];
            break;
        }
        case FMIDurationFormatterStyleTimeLeadingZero: {
            formattedDuration = [NSString stringWithFormat:@"%02ld:%02ld", (long)[duration hours], (long)[duration minutes]];
            break;
        }
        case FMIDurationFormatterStyleDecimalWithSymbol: {
            NSTimeInterval preparedDuration = [self durationForStringFromHoursFraction:[duration hours] minutesFraction:[duration minutes]];
            formattedDuration = [NSString stringWithFormat:@"%@h", [self.numberFormatter stringFromNumber:@(preparedDuration)]];
            break;
        }
        case FMIDurationFormatterStyleDecimal:
        default: {
            NSTimeInterval preparedDuration = [self durationForStringFromHoursFraction:[duration hours] minutesFraction:[duration minutes]];
            formattedDuration = [NSString stringWithFormat:@"%@", [self.numberFormatter stringFromNumber:@(preparedDuration)]];
            break;
        }
    }
    NSString *result = [NSString stringWithFormat:([duration isNegative]) ? FMIDurationFormatterFormatWithNumericPrefixForNegativeDuration : FMIDurationFormatterFormatWithNumericPrefixForPositiveDuration, formattedDuration];

    return result;
}

- (double)durationForStringFromHoursFraction:(NSInteger)hours minutesFraction:(NSInteger)minutes {
    return ((double)hours + ((double)minutes / 60));
}

- (NSString *)editingStringFromDuration:(FMIDuration *)duration {
    return [self editingStringForObjectValue:duration];
}

- (NSString *)editingStringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[FMIDuration class]]) {
        return nil;
    }
    FMIDuration *duration = (FMIDuration *)anObject;
    NSInteger minutes = [self minutesForEditingStringFromMinutesFraction:[duration minutes]];
    NSTimeInterval preparedDuration = [self durationForEditingStringFromHoursFraction:[duration hours] minutesFraction:minutes];
    NSString *formattedDuration = [NSString stringWithFormat:FMIDurationFormatterFormatForEditingString, preparedDuration];
    NSString *result = [NSString stringWithFormat:([duration isNegative]) ? FMIDurationFormatterFormatWithNumericPrefixForNegativeDuration : FMIDurationFormatterFormatWithNumericPrefixForPositiveDuration, formattedDuration];
    return result;
}

- (double)durationForEditingStringFromHoursFraction:(NSInteger)hours minutesFraction:(NSInteger)minutes {
    return ((double)(hours * 100 + minutes));
}

- (NSInteger)minutesForEditingStringFromMinutesFraction:(NSInteger)minutes {
    return ([self isDecimalStyle]) ? round((double)minutes / 60 * 100) : minutes;
}

- (void)setLocale:(NSLocale *)locale {
    _locale = locale;
    [self.numberFormatter setLocale:_locale];
}

- (BOOL)isTimeStyle {
    return ([self style] == FMIDurationFormatterStyleTime || [self style] == FMIDurationFormatterStyleTimeLeadingZero);
}

- (BOOL)isDecimalStyle {
    return ([self style] == FMIDurationFormatterStyleDecimal || [self style] == FMIDurationFormatterStyleDecimalWithSymbol);
}

@end
