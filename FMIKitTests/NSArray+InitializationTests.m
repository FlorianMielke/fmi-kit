//
//  NSArray+InitializationTests.m
//
//  Created by Florian on 15.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSArray+Initialization.h"


@interface NSArray_InitializationTests : XCTestCase

@end


@implementation NSArray_InitializationTests


#pragma mark -
#pragma mark Creation from NSIndexSet

- (void)testReturnsEmptyArrayForNilIndexes
{
    XCTAssertEqual([[NSArray arrayWithIndexes:nil] count], (NSUInteger)0);
}


- (void)testReturnsEmptyArrayForEmtptyIndexes
{
    XCTAssertEqual([[NSArray arrayWithIndexes:[NSIndexSet indexSet]] count], (NSUInteger)0);
}


- (void)testReturnsArrayWithIndexes
{
    // Given
    NSArray *anArray = [NSArray arrayWithObjects:@1, @2, @4, nil];
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    [indexes addIndex:1];
    [indexes addIndex:2];
    [indexes addIndex:4];
    
    // Then
    XCTAssertTrue([[NSArray arrayWithIndexes:indexes] isEqualToArray:anArray]);
}


@end
