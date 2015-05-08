//
//  NSDataFile+AdditionsTests.m
//  MeetingMinutes
//
//  Created by Florian on 08.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSData+FileAdditions.h"


@interface NSData_FileAdditionsTests : XCTestCase

@property (nonatomic, strong) NSData *testData;

@end


@implementation NSData_FileAdditionsTests

#pragma mark -
#pragma mark Fixture

- (void)setUp
{
    [super setUp];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *pathToPlistData = [bundle pathForResource:@"TestImageBig" ofType:@"jpeg"];
    _testData = [NSData dataWithContentsOfFile:pathToPlistData];
}


- (void)tearDown
{
    [self setTestData:nil];
    
    [super tearDown];
}


#pragma mark -
#pragma mark Tests

- (void)testWritingToTempDirectoryReturnsFileURL
{
    NSURL *resultURL = [[self testData] writeToTemporaryDictionaryUsingFileName:@"Test" type:@"jpeg"];
    XCTAssertTrue([resultURL isFileURL]);
}


- (void)testPassingNoFileNameIsNotAccepted
{
    XCTAssertThrows([[self testData] writeToTemporaryDictionaryUsingFileName:nil type:@"txt"]);
}


@end
