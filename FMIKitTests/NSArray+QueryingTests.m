//
//  NSArray+QueryingTests.m
//
//  Created by Florian Mielke on 03.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+Querying.h"


@interface NSArray_QueryingTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) NSArray *sut;

@end



@implementation NSArray_QueryingTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];
    
    _sut = @[@"Lorem", @"Ipsum", @"Is"];
}


- (void)tearDown
{
    _sut = nil;
    
    [super tearDown];
}



#pragma mark - Contains string

- (void)testContainsStringReturnsTrueWhenSucceed
{
    XCTAssertTrue([[self sut] containsString:@"Lorem"]);
}


- (void)testContainsStringReturnsFalesWhenFailes
{
    XCTAssertFalse([[self sut] containsString:@"Loremi"]);
}


- (void)testContainsStringIgnoresNonStringObjects
{

    NSArray *invalidArray = @[@1, @"Lorem"];
    
    XCTAssertTrue([invalidArray containsString:@"Lorem"]);
}



#pragma mark - Validate bounds

- (void)testArrayShouldReturnTrueForIndexInBounds
{
    XCTAssertTrue([_sut fm_isIndexInBoundsOfArray:(NSUInteger)0]);
    XCTAssertTrue([_sut fm_isIndexInBoundsOfArray:(NSUInteger)1]);
    XCTAssertTrue([_sut fm_isIndexInBoundsOfArray:(NSUInteger)2]);
    XCTAssertFalse([_sut fm_isIndexInBoundsOfArray:(NSUInteger)3]);
    XCTAssertFalse([_sut fm_isIndexInBoundsOfArray:(NSUInteger)NSNotFound]);
}



#pragma mark - Empty array

- (void)testArrayShouldCheckIfItsEmptyOrNot
{
    [self verifyWhenAskingAnArray:@[] toBeEmptyReturns:YES];
    [self verifyWhenAskingAnArray:@[@"A"] toBeEmptyReturns:NO];
    [self verifyWhenAskingAnArray:@[@"A", @"B"] toBeEmptyReturns:NO];
    
}


- (void)verifyWhenAskingAnArray:(NSArray *)anArray toBeEmptyReturns:(BOOL)shouldBeEmpty
{
    XCTAssertEqual([anArray fm_isEmpty], shouldBeEmpty);
}



@end
