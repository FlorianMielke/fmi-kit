//
//  Created by Florian Mielke on 11.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMIEventParser.h"

@interface FMIEventParserTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIEventParser *subject;
@property (NS_NONATOMIC_IOSONLY) EKEventStore *sampleEventStore;
@property (NS_NONATOMIC_IOSONLY) EKEvent *sampleEvent;

@end

@implementation FMIEventParserTests

- (void)setUp {
    [super setUp];
    self.sampleEventStore = [[EKEventStore alloc] init];
    self.sampleEvent = [EKEvent eventWithEventStore:[self sampleEventStore]];
    self.subject = [[FMIEventParser alloc] initWithEvent:[self sampleEvent]];
}

- (void)tearDown {
    [self setSubject:nil];
    [self setSampleEvent:nil];
    [self setSampleEventStore:nil];
    [super tearDown];
}

- (void)testEventParserIsInitialized {
    XCTAssertNotNil(self.subject);
}

- (void)testEventParserHasEvent {
    XCTAssertEqualObjects(self.subject.event, [self sampleEvent]);
}

- (void)testEventParserIsNotInitializedForNilEvent {
    XCTAssertThrows((void) [[FMIEventParser alloc] initWithEvent:nil]);
}

- (void)testDataIsNilForNilEvent {
    XCTAssertNil([FMIEventParser dataFromEvent:nil]);
}

- (void)testParseDescriptionReturnsDescriptionPropertyOnlyStringForNilNotes {
    XCTAssertEqualObjects([self.subject parseDescriptionFromNotes:nil], @"DESCRIPTION:");
}

- (void)testParseDescriptionReturnsDescriptionPropertyOnlyStringForEmptyNotes {
    XCTAssertEqualObjects([self.subject parseDescriptionFromNotes:@""], @"DESCRIPTION:");
}

- (void)testParseDescriptionReturnsAStringStartingWithDescriptionProperty {
    XCTAssertEqualObjects([self.subject parseDescriptionFromNotes:@"Lorem ipsum"], @"DESCRIPTION:Lorem ipsum");
}

- (void)testParseDescriptionReturnsAnEscapedString {
    XCTAssertEqualObjects([self.subject parseDescriptionFromNotes:@"Lorem \\ipsum, lorem."], @"DESCRIPTION:Lorem \\\\ipsum\\, lorem.");
}

- (void)testParseSummaryReturnsSummaryPropertyOnlyStringForNilTitle {
    XCTAssertEqualObjects([self.subject parseSummaryFromTitle:nil], @"SUMMARY:");
}

- (void)testParseSummaryReturnsSummaryPropertyOnlyStringForEmptyTitle {
    XCTAssertEqualObjects([self.subject parseSummaryFromTitle:@""], @"SUMMARY:");
}

- (void)testParseSummaryReturnsAStringStartingWithSummaryProperty {
    XCTAssertEqualObjects([self.subject parseSummaryFromTitle:@"Lorem ipsum"], @"SUMMARY:Lorem ipsum");
}

- (void)testParseSummaryReturnsAnEscapedString {
    XCTAssertEqualObjects([self.subject parseSummaryFromTitle:@"Lorem \\ipsum, lorem."], @"SUMMARY:Lorem \\\\ipsum\\, lorem.");
}

- (void)testEscapeTextReturnsNilForNilString {
    XCTAssertNil([self.subject escapedStringFromString:nil]);
}

- (void)testEscapeTextReturnsAString {
    XCTAssertEqualObjects([self.subject escapedStringFromString:@"Lorem ipsum."], @"Lorem ipsum.");
}

- (void)testEscapeTextEscapedBackslashes {
    XCTAssertEqualObjects([self.subject escapedStringFromString:@"Lorem \\ipsum."], @"Lorem \\\\ipsum.");
}

- (void)testEscapeTextEscapedCommas {
    XCTAssertEqualObjects([self.subject escapedStringFromString:@"Lorem ,ipsum."], @"Lorem \\,ipsum.");
}

- (void)testEscapeTextEscapedSemicolons {
    XCTAssertEqualObjects([self.subject escapedStringFromString:@"Lorem; ipsum."], @"Lorem\\; ipsum.");
}

- (void)testEscapeTextEscapedLineBreaks {
    XCTAssertEqualObjects([self.subject escapedStringFromString:@"Lorem\n ipsum."], @"Lorem\\n ipsum.");
}

- (void)testEscapeTextDoesNotEscapeColons {
    XCTAssertEqualObjects([self.subject escapedStringFromString:@"Lorem: ipsum."], @"Lorem: ipsum.");
}

@end
