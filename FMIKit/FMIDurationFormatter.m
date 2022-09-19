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

- (instancetype)initWithDurationStyle:(enum FMIDurationFormatterStyle)style {
  self = [super init];
  if (self) {
    self.style = style;
    self.locale = [NSLocale autoupdatingCurrentLocale];
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    self.numberFormatter.locale = self.locale;
    self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    self.numberFormatter.roundingMode = NSNumberFormatterRoundHalfUp;
    self.numberFormatter.maximumFractionDigits = 2;
    self.numberFormatter.minimumFractionDigits = 2;
  }
  return self;
}

- (instancetype)init {
  return [self initWithDurationStyle:FMIDurationFormatterStyleTime];
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
  NSTimeInterval seconds = 0;
  if (string != nil && ![string isEqualToString:@""]) {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    double stringDuration = [self stringDurationFromString:string scanner:scanner];
    if ([self isDurationLessThanAnHour:stringDuration]) {
      seconds = [self timeIntervalFromMinutes:stringDuration];
    } else {
      seconds = [self timeIntervalFromStringDuration:stringDuration];
      if ((stringDuration < 0)) {
        seconds *= (-1);
      }
    }
  }
  returnValue = YES;
  if (obj) {
    *obj = [FMIDuration durationWithSeconds:seconds];
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
