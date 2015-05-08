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

@property (nonatomic, strong) FMIDurationFormatter *sut;
@property (nonatomic, strong) NSLocale *germanLocale;

@property (nonatomic, assign) NSTimeInterval duration0h00m;
@property (nonatomic, assign) NSTimeInterval duration0h15m;
@property (nonatomic, assign) NSTimeInterval durationMinus0h15m;
@property (nonatomic, assign) NSTimeInterval duration8h00m;
@property (nonatomic, assign) NSTimeInterval durationMinus8h00m;
@property (nonatomic, assign) NSTimeInterval duration8h30m;
@property (nonatomic, assign) NSTimeInterval durationMinus8h30m;
@property (nonatomic, assign) NSTimeInterval duration7h45m;
@property (nonatomic, assign) NSTimeInterval durationMinus7h45m;
@property (nonatomic, assign) NSTimeInterval duration7h46m;
@property (nonatomic, assign) NSTimeInterval durationMinus7h46m;
@property (nonatomic, assign) NSTimeInterval durationMinus0h34_96m;

@end



@implementation FMIDurationFormatterTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    _sut = [[FMIDurationFormatter alloc] init];
    
    _germanLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];

    _duration0h00m = 0;
    _duration0h15m = 900;
    _durationMinus0h15m = -900;
    _duration8h00m = 28800;
    _durationMinus8h00m = -28800;
    _duration8h30m = 30600;
    _durationMinus8h30m = -30600;
    _duration7h45m = 27900;
    _durationMinus7h45m = -27900;
    _duration7h46m = 27960;
    _durationMinus7h46m = -27960;
    self.durationMinus0h34_96m = -2098;
}


- (void)tearDown
{
    _sut = nil;
    _germanLocale = nil;
    
    [super tearDown];
}



#pragma mark - Initialization

- (void)testFormatterIsInitialized
{
    XCTAssertNotNil([self sut]);
}


- (void)testDurationStyleIsTimeByDefault
{
    XCTAssertEqual([[self sut] style], FMIDurationFormatterStyleTime);
}


- (void)testLocaleIsCurrentLocaleByDefault
{
    XCTAssertEqualObjects([[[self sut] locale] localeIdentifier], [[NSLocale autoupdatingCurrentLocale] localeIdentifier]);
}



#pragma mark - Object equivalent

- (void)testDurationFromStringForDurationStyleTime
{
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


- (void)testDurationFromStringForDurationStyleDecimal
{
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



#pragma mark - Textual representation

- (void)testFormattedStringReturnsNilForNonDurationObject
{
    XCTAssertNil([[self sut] stringFromDuration:(FMIDuration *)@(0)]);
}


- (void)testFormattedStringFromDurationStyleTime
{
    [self verifyDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"0:00"];
    [self verifyDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"0:15"];
    [self verifyDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"-0:15"];
    [self verifyDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"8:00"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"-8:00"];
    [self verifyDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"8:30"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"-8:30"];
    [self verifyDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"7:45"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleTime returnsFormattedString:@"-7:45"];
    [self verifyDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleTime returnsFormattedString:@"-0:35"];
}


- (void)testFormattedStringFromDurationStyleTimeLeadingZero
{
    [self verifyDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"00:00"];
    [self verifyDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"00:15"];
    [self verifyDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"-00:15"];
    [self verifyDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"08:00"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"-08:00"];
    [self verifyDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"08:30"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"-08:30"];
    [self verifyDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"07:45"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"-07:45"];
    [self verifyDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleTimeLeadingZero returnsFormattedString:@"-00:35"];
}

- (void)testFormattedStringFromDurationStyleDecimal
{
    [self verifyDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"0.00"];
    [self verifyDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"0.25"];
    [self verifyDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-0.25"];
    [self verifyDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"8.00"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-8.00"];
    [self verifyDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"8.50"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-8.50"];
    [self verifyDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"7.75"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-7.75"];
    [self verifyDurationWithTimeInterval:[self duration7h46m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"7.77"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h46m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-7.77"];
    [self verifyDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-0.58"];
    
    [[self sut] setLocale:[self germanLocale]];

    [self verifyDurationWithTimeInterval:[self duration7h46m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"7,77"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h46m] style:FMIDurationFormatterStyleDecimal returnsFormattedString:@"-7,77"];
}

- (void)testFormattedStringFromDurationStyleDezimalWithSymbol
{
    [self verifyDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"0.00h"];
    [self verifyDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"0.25h"];
    [self verifyDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-0.25h"];
    [self verifyDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"8.00h"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-8.00h"];
    [self verifyDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"8.50h"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-8.50h"];
    [self verifyDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"7.75h"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-7.75h"];
    [self verifyDurationWithTimeInterval:[self duration7h46m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"7.77h"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h46m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-7.77h"];
    [self verifyDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-0.58h"];
    
    [[self sut] setLocale:[self germanLocale]];
    
    [self verifyDurationWithTimeInterval:[self duration7h46m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"7,77h"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h46m] style:FMIDurationFormatterStyleDecimalWithSymbol returnsFormattedString:@"-7,77h"];
}



#pragma mark - Editing textual representation

- (void)testEditingStringReturnsNilForNonDurationObject
{
    XCTAssertNil([[self sut] editingStringFromDuration:(FMIDuration *)@(0)]);
}


- (void)testEditingStringFromDurationStyleTime
{
    [self verifyDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleTime returnsEditingString:@"0"];
    [self verifyDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleTime returnsEditingString:@"15"];
    [self verifyDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleTime returnsEditingString:@"-15"];
    [self verifyDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleTime returnsEditingString:@"800"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleTime returnsEditingString:@"-800"];
    [self verifyDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleTime returnsEditingString:@"830"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleTime returnsEditingString:@"-830"];
    [self verifyDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleTime returnsEditingString:@"745"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleTime returnsEditingString:@"-745"];
    [self verifyDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleTime returnsEditingString:@"-35"];
}


- (void)testEditingStringFromDurationStyleDecimal
{
    [self verifyDurationWithTimeInterval:[self duration0h00m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"0"];
    [self verifyDurationWithTimeInterval:[self duration0h15m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"25"];
    [self verifyDurationWithTimeInterval:[self durationMinus0h15m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-25"];
    [self verifyDurationWithTimeInterval:[self duration8h00m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"800"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h00m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-800"];
    [self verifyDurationWithTimeInterval:[self duration8h30m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"850"];
    [self verifyDurationWithTimeInterval:[self durationMinus8h30m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-850"];
    [self verifyDurationWithTimeInterval:[self duration7h45m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"775"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h45m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-775"];
    [self verifyDurationWithTimeInterval:[self duration7h46m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"777"];
    [self verifyDurationWithTimeInterval:[self durationMinus7h46m] style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-777"];
    [self verifyDurationWithTimeInterval:self.durationMinus0h34_96m style:FMIDurationFormatterStyleDecimal returnsEditingString:@"-58"];
}



#pragma mark - Utilities

- (void)verifyDurationFromString:(NSString *)string style:(FMIDurationFormatterStyle)style returnsTimeInterval:(NSTimeInterval)timeInterval
{
    // Given
    [[self sut] setStyle:style];
    
    // When
    FMIDuration *duration = [[self sut] durationFromString:string];
    
    // Then
    XCTAssertEqual([duration timeInterval], timeInterval);
}


- (void)verifyDurationWithTimeInterval:(NSTimeInterval)timeInterval style:(FMIDurationFormatterStyle)style returnsFormattedString:(NSString *)string
{
    // Given
    [[self sut] setStyle:style];
    FMIDuration *duration = [FMIDuration durationWithTimeInterval:timeInterval];
    
    // When
    NSString *formattedString = [[self sut] stringFromDuration:duration];
    
    // Then
    XCTAssertEqualObjects(formattedString, string);
}


- (void)verifyDurationWithTimeInterval:(NSTimeInterval)timeInterval style:(FMIDurationFormatterStyle)style returnsEditingString:(NSString *)editingString
{
    // Given
    [[self sut] setStyle:style];
    FMIDuration *duration = [FMIDuration durationWithTimeInterval:timeInterval];
    
    // When
    NSString *formattedString = [[self sut] editingStringFromDuration:duration];
    
    // Then
    XCTAssertEqualObjects(formattedString, editingString);
}

@end
