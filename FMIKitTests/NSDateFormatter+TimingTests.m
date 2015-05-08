//
//  NSDateFormatter+TimingTests.m
//
//  Created by Florian Mielke on 29.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSDateFormatter+Timing.h"


@interface NSDateFormatter_TimingTests : XCTestCase

@property (nonatomic, strong) NSDateFormatter *sut;
@property (nonatomic, strong) NSLocale *usLocale;
@property (nonatomic, strong) NSLocale *germanLocale;

@end



@implementation NSDateFormatter_TimingTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    _sut = [[NSDateFormatter alloc] init];
    _usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    _germanLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
}


- (void)tearDown
{
    _sut = nil;
    _usLocale = nil;
    _germanLocale = nil;
    
    [super tearDown];
}



#pragma mark - Initialization

- (void)testDateFormatterShouldBeInitialized
{
    XCTAssertNotNil(_sut);
}


- (void)test24HourStyleValidationShouldReturnNoForEnglishLocale
{
    // When
    [_sut setLocale:_usLocale];
    
    // Then
    XCTAssertFalse([_sut is24HourStyle]);
}


- (void)test24HourStyleValidationShouldReturnYesForGermanLocale
{
    // When
    [_sut setLocale:_germanLocale];
    
    // Then
    XCTAssertTrue([_sut is24HourStyle]);
}


- (void)testCalendarDateAndTimeFormatShouldReturnCorrectFormatFor24HourStyle
{
    // Given
    [_sut setLocale:_germanLocale];
    
    // Then
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"yyyyMMMdHHmmE" options:0 locale:_germanLocale];
    XCTAssertEqualObjects([_sut calendarDateAndTimeFormat], format);
}


- (void)testCalendarDateAndTimeFormatShouldReturnCorrectFormatFor12HourStyle
{
    // Given
    [_sut setLocale:_usLocale];
    
    // Then
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"yyyyMMMdhmmEa" options:0 locale:_usLocale];
    XCTAssertEqualObjects([_sut calendarDateAndTimeFormat], format);
}


- (void)testCalendarDateFormatShouldReturnCorrectFormatFor24HourStyle
{
    // Given
    [_sut setLocale:_germanLocale];

    // Then
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"yyyyMMMMdE" options:0 locale:_germanLocale];
    XCTAssertEqualObjects([_sut calendarDateFormat], format);
}


- (void)testCalendarDateFormatShouldReturnCorrectFormatFor12HourStyle
{
    // Given
    [_sut setLocale:_usLocale];
    
    // Then
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"yyyyMMMMdEa" options:0 locale:_usLocale];
    XCTAssertEqualObjects([_sut calendarDateFormat], format);
}


- (void)testCalendarFormatShouldBeISO8601
{
    XCTAssertEqualObjects([_sut iso8601DateFormat], @"yyyy-MM-dd'T'HH:mm");
}


@end
