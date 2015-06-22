//
//  FMIDurationFormatterTests.m
//
//  Created by Florian Mielke on 09.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "FMIDurationFormatter.h"
#import "FMIDuration.h"

@interface FMIDurationFormatterTests : XCTestCase

@property (nonatomic) FMIDurationFormatter *formatter;
@property (nonatomic) NSLocale *germanLocale;
@property (nonatomic) NSTimeInterval duration0h00m;
@property (nonatomic) NSTimeInterval duration0h15m;
@property (nonatomic) NSTimeInterval durationMinus0h15m;
@property (nonatomic) NSTimeInterval duration8h00m;
@property (nonatomic) NSTimeInterval durationMinus8h00m;
@property (nonatomic) NSTimeInterval duration8h30m;
@property (nonatomic) NSTimeInterval durationMinus8h30m;
@property (nonatomic) NSTimeInterval duration7h45m;
@property (nonatomic) NSTimeInterval durationMinus7h45m;
@property (nonatomic) NSTimeInterval duration7h46m;
@property (nonatomic) NSTimeInterval durationMinus7h46m;
@property (nonatomic) NSTimeInterval durationMinus0h34_96m;

@end

@implementation FMIDurationFormatterTests

- (void)setUp {
    [super setUp];

    self.formatter = [[FMIDurationFormatter alloc] init];
    self.germanLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    self.duration0h00m = 0;
    self.duration0h15m = 900;
    self.durationMinus0h15m = -900;
    self.duration8h00m = 28800;
    self.durationMinus8h00m = -28800;
    self.duration8h30m = 30600;
    self.durationMinus8h30m = -30600;
    self.duration7h45m = 27900;
    self.durationMinus7h45m = -27900;
    self.duration7h46m = 27960;
    self.durationMinus7h46m = -27960;
    self.durationMinus0h34_96m = -2098;
}

- (void)testFormatterIsInitialized {
    XCTAssertNotNil([self formatter]);
}

- (void)testDurationStyleIsTimeByDefault {
    XCTAssertEqual([[self formatter] style], FMIDurationFormatterStyleTime);
}

- (void)testLocaleIsCurrentLocaleByDefault {
    XCTAssertEqualObjects([[[self formatter] locale] localeIdentifier], [[NSLocale autoupdatingCurrentLocale] localeIdentifier]);
}

- (void)testDurationFromStringForDurationStyleTime {
    [self verifyDurationFromString:nil style:FMIDurationFormatterStyleTime returnsTimeInterval:self.duration0h00m];
    [self verifyDurationFromString:@"" style:FMIDurationFormatterStyleTime returnsTimeInterval:self.duration0h00m];
    [self verifyDurationFromString:@"0" style:FMIDurationFormatterStyleTime returnsTimeInterval:[self duration0h00m]];
    [self verifyDurationFromString:@"15" style:FMIDurationFormatterStyleTime returnsTimeInterval:[self duration0h15m]];
    [self verifyDurationFromString:@"-15" style:FMIDurationFormatterStyleTime returnsTimeInterval:[self durationMinus0h15m]];
    [self verifyDurationFromString:@"800" style:FMIDurationFormatterStyleTime returnsTimeInterval:[self duration8h00m]];
    [self verifyDurationFromString:@"-800" style:FMIDurationFormatterStyleTime returnsTimeInterval:[self durationMinus8h00m]];
    [self verifyDurationFromString:@"830" style:FMIDurationFormatterStyleTime returnsTimeInterval:[self duration8h30m]];
    [self verifyDurationFromString:@"-830" style:FMIDurationFormatterStyleTime returnsTimeInterval:[self durationMinus8h30m]];
    [self verifyDurationFromString:@"745" style:FMIDurationFormatterStyleTime returnsTimeInterval:[self duration7h45m]];
    [self verifyDurationFromString:@"-745" style:FMIDurationFormatterStyleTime returnsTimeInterval:[self durationMinus7h45m]];
}

- (void)testDurationFromStringForDurationStyleDecimal {
    [self verifyDurationFromString:nil style:FMIDurationFormatterStyleDecimal returnsTimeInterval:self.duration0h00m];
    [self verifyDurationFromString:@"" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:self.duration0h00m];
    [self verifyDurationFromString:@"0" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self duration0h00m]];
    [self verifyDurationFromString:@"25" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self duration0h15m]];
    [self verifyDurationFromString:@"-25" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self durationMinus0h15m]];
    [self verifyDurationFromString:@"800" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self duration8h00m]];
    [self verifyDurationFromString:@"-800" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self durationMinus8h00m]];
    [self verifyDurationFromString:@"850" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self duration8h30m]];
    [self verifyDurationFromString:@"-850" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self durationMinus8h30m]];
    [self verifyDurationFromString:@"775" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self duration7h45m]];
    [self verifyDurationFromString:@"-775" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self durationMinus7h45m]];
    [self verifyDurationFromString:@"777" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self duration7h46m]];
    [self verifyDurationFromString:@"-777" style:FMIDurationFormatterStyleDecimal returnsTimeInterval:[self durationMinus7h46m]];
}

- (void)testFormattedStringReturnsNilForNonDurationObject {
    XCTAssertNil([[self formatter] stringFromDuration:(FMIDuration *)@(0)]);
}

- (void)testFormattedStringFromDurationStyleTime {
    [self verifyStringFromDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"0:00"];
    [self verifyStringFromDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"0:15"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"-0:15"];
    [self verifyStringFromDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"8:00"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"-8:00"];
    [self verifyStringFromDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"8:30"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"-8:30"];
    [self verifyStringFromDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"7:45"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"-7:45"];
    [self verifyStringFromDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleTime returnsFormattedString:@"-0:35"];
}

- (void)testFormattedStringFromDurationStyleTimeLeadingZero {
    [self verifyStringFromDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"00:00"];
    [self verifyStringFromDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"00:15"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"-00:15"];
    [self verifyStringFromDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"08:00"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"-08:00"];
    [self verifyStringFromDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"08:30"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"-08:30"];
    [self verifyStringFromDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"07:45"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"-07:45"];
    [self verifyStringFromDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"-00:35"];
}

- (void)testFormattedStringFromDurationStyleDecimal {
    [self verifyStringFromDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"0.00"];
    [self verifyStringFromDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"0.25"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-0.25"];
    [self verifyStringFromDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"8.00"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-8.00"];
    [self verifyStringFromDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"8.50"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-8.50"];
    [self verifyStringFromDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"7.75"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-7.75"];
    [self verifyStringFromDurationWithTimeInterval:[self duration7h46m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"7.77"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus7h46m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-7.77"];
    [self verifyStringFromDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-0.58"];

    [[self formatter] setLocale:[self germanLocale]];

    [self verifyStringFromDurationWithTimeInterval:[self duration7h46m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"7,77"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus7h46m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-7,77"];
}

- (void)testFormattedStringFromDurationStyleDezimalWithSymbol {
    [self verifyStringFromDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"0.00h"];
    [self verifyStringFromDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"0.25h"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-0.25h"];
    [self verifyStringFromDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"8.00h"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-8.00h"];
    [self verifyStringFromDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"8.50h"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-8.50h"];
    [self verifyStringFromDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"7.75h"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-7.75h"];
    [self verifyStringFromDurationWithTimeInterval:[self duration7h46m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"7.77h"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus7h46m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-7.77h"];
    [self verifyStringFromDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-0.58h"];

    [[self formatter] setLocale:[self germanLocale]];

    [self verifyStringFromDurationWithTimeInterval:[self duration7h46m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"7,77h"];
    [self verifyStringFromDurationWithTimeInterval:[self durationMinus7h46m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-7,77h"];
}

- (void)testEditingStringReturnsNilForNonDurationObject {
    XCTAssertNil([[self formatter] editingStringFromDuration:(FMIDuration *)@(0)]);
}

- (void)testEditingStringFromDurationStyleTime {
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleTime returnsEditingString:@"0"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleTime returnsEditingString:@"15"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleTime returnsEditingString:@"-15"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleTime returnsEditingString:@"800"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleTime returnsEditingString:@"-800"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleTime returnsEditingString:@"830"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleTime returnsEditingString:@"-830"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleTime returnsEditingString:@"745"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleTime returnsEditingString:@"-745"];
    [self verifyEditingStringFromDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleTime returnsEditingString:@"-35"];
}

- (void)testEditingStringFromDurationStyleDecimal {
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"0"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"25"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-25"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"800"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-800"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"850"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-850"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"775"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-775"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self duration7h46m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"777"];
    [self verifyEditingStringFromDurationWithTimeInterval:[self durationMinus7h46m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-777"];
    [self verifyEditingStringFromDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-58"];
}

- (void)verifyDurationFromString:(NSString *)string style:(FMIDurationFormatterStyle)style returnsTimeInterval:(NSTimeInterval)timeInterval {
    [[self formatter] setStyle:style];
    FMIDuration *duration = [[self formatter] durationFromString:string];
    XCTAssertEqual([duration timeInterval], timeInterval);
}

- (void)verifyStringFromDurationWithTimeInterval:(NSTimeInterval)timeInterval style:(FMIDurationFormatterStyle)style returnsFormattedString:(NSString *)string {
    [[self formatter] setStyle:style];
    FMIDuration *duration = [FMIDuration durationWithTimeInterval:timeInterval];
    NSString *formattedString = [[self formatter] stringFromDuration:duration];
    XCTAssertEqualObjects(formattedString, string);
}

- (void)verifyEditingStringFromDurationWithTimeInterval:(NSTimeInterval)timeInterval style:(FMIDurationFormatterStyle)style returnsEditingString:(NSString *)editingString {
    [[self formatter] setStyle:style];
    FMIDuration *duration = [FMIDuration durationWithTimeInterval:timeInterval];
    NSString *formattedString = [[self formatter] editingStringFromDuration:duration];
    XCTAssertEqualObjects(formattedString, editingString);
}

@end
