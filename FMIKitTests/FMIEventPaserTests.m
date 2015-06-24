//
//  Created by Florian Mielke on 11.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "FMIEventParser.h"
#import <EventKit/EventKit.h>


@interface FMIEventParserTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIEventParser *sut;
@property (NS_NONATOMIC_IOSONLY) EKEventStore *sampleEventStore;
@property (NS_NONATOMIC_IOSONLY) EKEvent *sampleEvent;

@end


@implementation FMIEventParserTests


#pragma mark -
#pragma mark Fixture

- (void)setUp
{
    _sampleEventStore = [[EKEventStore alloc] init];
    _sampleEvent = [EKEvent eventWithEventStore:[self sampleEventStore]];
    _sut = [[FMIEventParser alloc] initWithEvent:[self sampleEvent]];
    
    [super setUp];
}


- (void)tearDown
{
    [self setSut:nil];
    [self setSampleEvent:nil];
    [self setSampleEventStore:nil];
    
    [super tearDown];
}



#pragma mark -
#pragma mark Initalizing

- (void)testEventParserIsInitialized
{
    XCTAssertNotNil([self sut]);
}


- (void)testEventParserHasEvent
{
    XCTAssertEqualObjects([[self sut] event], [self sampleEvent]);
}


- (void)testEventParserIsNotInitializedForNilEvent
{
    XCTAssertThrows((void)[[FMIEventParser alloc] initWithEvent:nil]);
}


- (void)testDataIsNilForNilEvent
{
    XCTAssertNil([FMIEventParser dataFromEvent:nil]);
}



#pragma mark -
#pragma mark Parse description

- (void)testParseDescriptionReturnsDescriptionPropertyOnlyStringForNilNotes
{
    XCTAssertEqualObjects([[self sut] parseDescriptionFromNotes:nil], @"DESCRIPTION:");
}


- (void)testParseDescriptionReturnsDescriptionPropertyOnlyStringForEmptyNotes
{
    XCTAssertEqualObjects([[self sut] parseDescriptionFromNotes:@""], @"DESCRIPTION:");
}


- (void)testParseDescriptionReturnsAStringStartingWithDescriptionProperty
{
    XCTAssertEqualObjects([[self sut] parseDescriptionFromNotes:@"Lorem ipsum"], @"DESCRIPTION:Lorem ipsum");
}


- (void)testParseDescriptionReturnsAnEscapedString
{
    XCTAssertEqualObjects([[self sut] parseDescriptionFromNotes:@"Lorem \\ipsum, lorem."], @"DESCRIPTION:Lorem \\\\ipsum\\, lorem.");
}



#pragma mark -
#pragma mark Parse summary

- (void)testParseSummaryReturnsSummaryPropertyOnlyStringForNilTitle
{
    XCTAssertEqualObjects([[self sut] parseSummaryFromTitle:nil], @"SUMMARY:");
}


- (void)testParseSummaryReturnsSummaryPropertyOnlyStringForEmptyTitle
{
    XCTAssertEqualObjects([[self sut] parseSummaryFromTitle:@""], @"SUMMARY:");
}


- (void)testParseSummaryReturnsAStringStartingWithSummaryProperty
{
    XCTAssertEqualObjects([[self sut] parseSummaryFromTitle:@"Lorem ipsum"], @"SUMMARY:Lorem ipsum");
}


- (void)testParseSummaryReturnsAnEscapedString
{
    XCTAssertEqualObjects([[self sut] parseSummaryFromTitle:@"Lorem \\ipsum, lorem."], @"SUMMARY:Lorem \\\\ipsum\\, lorem.");
}




#pragma mark -
#pragma mark Escape text

- (void)testEscapeTextReturnsNilForNilString
{
    XCTAssertNil([[self sut] escapedStringFromString:nil]);
}


- (void)testEscapeTextReturnsAString
{
    XCTAssertEqualObjects([[self sut] escapedStringFromString:@"Lorem ipsum."], @"Lorem ipsum.");
}


- (void)testEscapeTextEscapedBackslashes
{
    XCTAssertEqualObjects([[self sut] escapedStringFromString:@"Lorem \\ipsum."], @"Lorem \\\\ipsum.");
}


- (void)testEscapeTextEscapedCommas
{
    XCTAssertEqualObjects([[self sut] escapedStringFromString:@"Lorem ,ipsum."], @"Lorem \\,ipsum.");
}


- (void)testEscapeTextEscapedSemicolons
{
    XCTAssertEqualObjects([[self sut] escapedStringFromString:@"Lorem; ipsum."], @"Lorem\\; ipsum.");
}


- (void)testEscapeTextEscapedLineBreaks
{
    XCTAssertEqualObjects([[self sut] escapedStringFromString:@"Lorem\n ipsum."], @"Lorem\\n ipsum.");
}


- (void)testEscapeTextDoesNotEscapeColons
{
    XCTAssertEqualObjects([[self sut] escapedStringFromString:@"Lorem: ipsum."], @"Lorem: ipsum.");
}


@end
