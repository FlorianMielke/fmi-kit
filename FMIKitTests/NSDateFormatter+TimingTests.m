//
//  NSDateFormatter+TimingTests.m
//
//  Created by Florian Mielke on 29.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDateFormatter+Timing.h"


@interface NSDateFormatter_TimingTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) NSDateFormatter *sut;
@property (NS_NONATOMIC_IOSONLY) NSLocale *usLocale;
@property (NS_NONATOMIC_IOSONLY) NSLocale *germanLocale;

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
    
    XCTAssertFalse([_sut is24HourStyle]);
}


- (void)test24HourStyleValidationShouldReturnYesForGermanLocale
{
    // When
    [_sut setLocale:_germanLocale];
    
    XCTAssertTrue([_sut is24HourStyle]);
}


- (void)testCalendarDateAndTimeFormatShouldReturnCorrectFormatFor24HourStyle
{

    [_sut setLocale:_germanLocale];
    
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"yyyyMMMdHHmmE" options:0 locale:_germanLocale];
    XCTAssertEqualObjects([_sut calendarDateAndTimeFormat], format);
}


- (void)testCalendarDateAndTimeFormatShouldReturnCorrectFormatFor12HourStyle
{

    [_sut setLocale:_usLocale];
    
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"yyyyMMMdhmmEa" options:0 locale:_usLocale];
    XCTAssertEqualObjects([_sut calendarDateAndTimeFormat], format);
}


- (void)testCalendarDateFormatShouldReturnCorrectFormatFor24HourStyle
{

    [_sut setLocale:_germanLocale];

    // Then
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"yyyyMMMMdE" options:0 locale:_germanLocale];
    XCTAssertEqualObjects([_sut calendarDateFormat], format);
}


- (void)testCalendarDateFormatShouldReturnCorrectFormatFor12HourStyle
{

    [_sut setLocale:_usLocale];
    
    NSString *format = [NSDateFormatter dateFormatFromTemplate:@"yyyyMMMMdEa" options:0 locale:_usLocale];
    XCTAssertEqualObjects([_sut calendarDateFormat], format);
}


- (void)testCalendarFormatShouldBeISO8601
{
    XCTAssertEqualObjects([_sut iso8601DateFormat], @"yyyy-MM-dd'T'HH:mm");
}


@end
