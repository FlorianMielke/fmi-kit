//
//  FMIDurationFormatter.m
//
//  Created by Florian Mielke on 09.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIDurationFormatter.h"
#import "FMIDuration.h"


@interface FMIDurationFormatter ()

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end



@implementation FMIDurationFormatter


#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _style = FMIDurationFormatterStyleTime;
        _locale = [NSLocale autoupdatingCurrentLocale];

        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setLocale:_locale];
        [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_numberFormatter setMaximumFractionDigits:2];
        [_numberFormatter setMinimumFractionDigits:2];
    }
    
    return self;
}



#pragma mark - Object equivalent

#define k60Minutes          3600
#define k60Seconds          60
#define k1HourFromString    100

- (FMIDuration *)durationFromString:(NSString *)string
{
    FMIDuration *duration;
    [self getObjectValue:&duration forString:string errorDescription:NULL];
    return duration;
}


- (BOOL)getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString  **)error
{
    BOOL returnValue = NO;
    
	NSTimeInterval timeInterval = 0;

    if (string != nil && ![string isEqualToString:@""])
    {
        NSScanner *scanner = [NSScanner scannerWithString:string];
        double stringDuration = [self stringDurationFromString:string scanner:scanner];
        
        if ([self isDurationLessThanAnHour:stringDuration])
        {
            timeInterval = [self timeIntervalFromMinutes:stringDuration];
        }
        else
        {
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


- (BOOL)isValidDurationString:(NSScanner *)scanner
{
    return [scanner scanDouble:NULL];
}


- (double)stringDurationFromString:(NSString *)string scanner:(NSScanner *)scanner
{
    double stringDuration;
    [scanner scanDouble:&stringDuration];
    return stringDuration;
}


- (NSTimeInterval)timeIntervalFromStringDuration:(double)stringDuration
{
    double time = fabs(stringDuration) / 100;
    double hours;
    double minutes = round(modf(time, &hours) * 100);
    
    return [self timeIntervalFromHours:hours] + [self timeIntervalFromMinutes:minutes];
}


- (NSTimeInterval)timeIntervalFromMinutes:(double)minutes
{
    return ([self isTimeStyle]) ? (minutes * k60Seconds) : (round(minutes / 100 * k60Seconds) * k60Seconds);
}


- (NSTimeInterval)timeIntervalFromHours:(double)hours
{
    return (hours * k60Minutes);
}


- (BOOL)isDurationLessThanAnHour:(double)duration
{
    return (fabs(duration) < k1HourFromString);
}



#pragma mark - Textual representation

- (NSString *)stringFromDuration:(FMIDuration *)duration
{
    return [self stringForObjectValue:duration];
}


- (NSString *)stringForObjectValue:(id)anObject
{
    if (![anObject isKindOfClass:[FMIDuration class]]) {
        return nil;
    }
    
    FMIDuration *duration = (FMIDuration *)anObject;
    
    NSString *formattedDuration = nil;
    
	if ([self isTimeStyle])
	{
		formattedDuration = [NSString stringWithFormat:[self formatForString], [duration hours], [duration minutes]];
	}
	else if ([self isDecimalStyle])
	{
        NSTimeInterval preparedDuration = [self durationForStringFromHoursFraction:[duration hours] minutesFraction:[duration minutes]];
        formattedDuration = [NSString stringWithFormat:[self formatForString], [self.numberFormatter stringFromNumber:@(preparedDuration)]];
	}

    NSString *result = [NSString stringWithFormat:[self formatWithNumericPrefixForDuration:duration], formattedDuration];
    
	return result;
}


- (double)durationForStringFromHoursFraction:(NSInteger)hours minutesFraction:(NSInteger)minutes
{
    return ((double)hours + ((double)minutes / 60));
}


- (NSString *)formatForString
{
    NSString *format = nil;
    
    switch ([self style])
    {
        case FMIDurationFormatterStyleTime:
            format = @"%d:%02d";
            break;
            
        case FMIDurationFormatterStyleTimeLeadingZero:
            format = @"%02d:%02d";
            break;

        case FMIDurationFormatterStyleDecimalWithSymbol:
            format = @"%@h";
            break;

        case FMIDurationFormatterStyleDecimal:
        default:
            format = @"%@";
            break;
    }
    
    return format;
}



#pragma mark - Editing textual representation

- (NSString *)editingStringFromDuration:(FMIDuration *)duration
{
    return [self editingStringForObjectValue:duration];
}


- (NSString *)editingStringForObjectValue:(id)anObject
{
    if (![anObject isKindOfClass:[FMIDuration class]]) {
        return nil;
    }
    
    FMIDuration *duration = (FMIDuration *)anObject;
    
    NSInteger minutes = [self minutesForEditingStringFromMinutesFraction:[duration minutes]];
    NSTimeInterval preparedDuration = [self durationForEditingStringFromHoursFraction:[duration hours] minutesFraction:minutes];
    NSString *formattedDuration = [NSString stringWithFormat:[self formatForEditingString], preparedDuration];
    
    NSString *result = [NSString stringWithFormat:[self formatWithNumericPrefixForDuration:duration], formattedDuration];
    
	return result;
}


- (double)durationForEditingStringFromHoursFraction:(NSInteger)hours minutesFraction:(NSInteger)minutes
{
    return ((double)(hours * 100 + minutes));
}


- (NSInteger)minutesForEditingStringFromMinutesFraction:(NSInteger)minutes
{
    return ([self isDecimalStyle]) ? round((double)minutes / 60 * 100) : minutes;
}


- (NSString *)formatForEditingString
{
    return @"%.0f";
}


- (NSString *)formatWithNumericPrefixForDuration:(FMIDuration *)duration
{
    return ([duration isNegative]) ? @"-%@" : @"%@";
}



#pragma mark - Locale

- (void)setLocale:(NSLocale *)locale
{
    _locale = locale;
   [self.numberFormatter setLocale:_locale];
}



#pragma mark - Utilites

- (BOOL)isTimeStyle
{
    return ([self style] == FMIDurationFormatterStyleTime || [self style] == FMIDurationFormatterStyleTimeLeadingZero);
}


- (BOOL)isDecimalStyle
{
    return ([self style] == FMIDurationFormatterStyleDecimal || [self style] == FMIDurationFormatterStyleDecimalWithSymbol);
}


@end
