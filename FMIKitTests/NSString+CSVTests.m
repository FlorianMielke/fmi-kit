//
//  NSString_CSVTests.m
//
//  Created by Florian Mielke on 14.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "NSString+CSV.h"


@interface NSString_CSVTests : XCTestCase

@property (nonatomic, strong) NSString *encloser;
@property (nonatomic, strong) NSString *delimiter;
@property (nonatomic, strong) NSString *stringWithoutComponents;
@property (nonatomic, strong) NSString *stringWithComponents;

@end



@implementation NSString_CSVTests


#pragma mark -
#pragma mark Fixture

- (void)setUp
{
    [super setUp];
    
    _encloser = @"\"";
    _delimiter = @",";
    _stringWithoutComponents = @"123";
    _stringWithComponents = @"\"123\",\"456\",\"789\"";
}


- (void)tearDown
{
    _encloser = nil;
    _delimiter = nil;
    _stringWithoutComponents = nil;
    _stringWithComponents = nil;
    
    [super tearDown];
}


#pragma mark -
#pragma mark Enclose string

- (void)testEnclosingStringReturnsNewStringEnclosedByGivenString
{
    // When
    NSString *enclosedString = [[self stringWithoutComponents] stringByEnclosingWithString:[self encloser]];
    
    // Then
    XCTAssertTrue([enclosedString hasPrefix:[self encloser]]);
    XCTAssertTrue([enclosedString hasSuffix:[self encloser]]);
}


- (void)testEnclosingEmptyStringReturnsNewStringEnclosedByGivenString
{
    // When
    NSString *enclosedString = [[self stringWithoutComponents] stringByEnclosingWithString:[self encloser]];
    
    // Then
    XCTAssertTrue([enclosedString hasPrefix:[self encloser]]);
    XCTAssertTrue([enclosedString hasSuffix:[self encloser]]);
}



#pragma mark -
#pragma mark Separate string

- (void)testSeparatingStringReturns3Components
{
    // When
    NSArray *components = [[self stringWithComponents] componentsSeparatedByDelimiter:[self delimiter] encloser:[self encloser]];
    
    // Then
    XCTAssertEqual([components count], (NSUInteger)3);
}


- (void)testSeparatingStringWithNilEncloserAndNilDelimiertReturnsAnArrayWithStringItself
{
    // When
    NSArray *components = [[self stringWithComponents] componentsSeparatedByDelimiter:nil encloser:nil];
    
    // Then
    XCTAssertEqualObjects([components lastObject], [self stringWithComponents]);
}


- (void)testSeparatingStringWithNilDelimiterReturnsStringItself
{
    // When
    NSArray *components = [[self stringWithComponents] componentsSeparatedByDelimiter:nil encloser:[self encloser]];
    
    // Then
    XCTAssertEqualObjects([components lastObject], [self stringWithComponents]);
}


- (void)testSeparatingStringWithNilEncloserIsAccepted
{
    // When
    NSArray *components = [[self stringWithComponents] componentsSeparatedByDelimiter:[self delimiter] encloser:nil];
    
    // Then
    XCTAssertEqual([components count], (NSUInteger)3);
}


@end
