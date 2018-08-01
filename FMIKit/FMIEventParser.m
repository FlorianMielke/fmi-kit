//
//  FMIEventParser.h
//
//  Created by Florian Mielke on 23/03/12.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

#import "FMIEventParser.h"
#import "NSString+Folding.h"

static NSDateFormatter *sDateFormatter;

@interface FMIEventParser ()

@property (NS_NONATOMIC_IOSONLY) EKEvent *event;

@end

@implementation FMIEventParser

+ (void)initialize {
    sDateFormatter = [[NSDateFormatter alloc] init];
    [sDateFormatter setDateFormat:@"yyyyMMdd'T'HHmmss"];
}

+ (NSData *)dataFromEvent:(EKEvent *)event {
    if (event == nil) {
        return nil;
    }
    FMIEventParser *eventParser = [[FMIEventParser alloc] initWithEvent:event];
    return [eventParser dataFromEvent];
}

- (instancetype)initWithEvent:(EKEvent *)event {
    if (event == nil) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"When initializing event parser the given event must not be nil" userInfo:nil] raise];
    }
    self = [super init];
    if (self != nil) {
        _event = event;
    }
    return self;
}

- (NSData *)dataFromEvent {
    NSMutableString *calString = [NSMutableString string];
    [calString appendString:@"BEGIN:VCALENDAR\n"];
    [calString appendString:@"VERSION:2.0\n"];
    [calString appendFormat:@"PRODID:-//Florian Mielke/http://Florian Mielke.com//EN\n"];
    [calString appendString:@"BEGIN:VEVENT\n"];
    [calString appendFormat:@"UID:%@\n", [self.event calendarItemExternalIdentifier]];
    [calString appendFormat:@"%@\n", [self parseSummaryFromTitle:self.event.title]];
    [calString appendFormat:@"DTSTAMP:%@Z\n", [sDateFormatter stringFromDate:[NSDate date]]];
    [calString appendFormat:@"DTSTART;TZID=%@:%@\n", self.event.timeZone.name, [sDateFormatter stringFromDate:self.event.startDate]];
    [calString appendFormat:@"DTEND;TZID=%@:%@\n", self.event.timeZone.name, [sDateFormatter stringFromDate:self.event.endDate]];
    [calString appendFormat:@"SEQUENCE:1\n"];
    [calString appendFormat:@"%@\n", [self parseDescriptionFromNotes:self.event.notes]];
    [calString appendString:@"END:VEVENT\n"];
    [calString appendString:@"END:VCALENDAR\n"];
    return [calString dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)parseTextFromString:(NSString *)aString {
    if (aString != nil && aString.length > 0) {
        aString = [self escapedStringFromString:aString];
        aString = [aString stringByFoldingToOctects:75];
    }
    return aString;
}

- (NSString *)parseDescriptionFromNotes:(NSString *)notes {
    NSString *rawDescription = @"DESCRIPTION:";
    if (notes != nil) {
        rawDescription = [rawDescription stringByAppendingString:notes];
    }
    return [self parseTextFromString:rawDescription];
}

- (NSString *)parseSummaryFromTitle:(NSString *)title {
    NSString *rawSummary = @"SUMMARY:";
    if (title != nil) {
        rawSummary = [rawSummary stringByAppendingString:title];
    }
    return [self parseTextFromString:rawSummary];
}

- (NSString *)escapedStringFromString:(NSString *)aString {
    aString = [aString stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    aString = [aString stringByReplacingOccurrencesOfString:@"," withString:@"\\,"];
    aString = [aString stringByReplacingOccurrencesOfString:@";" withString:@"\\;"];
    aString = [aString stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    return aString;
}

@end
