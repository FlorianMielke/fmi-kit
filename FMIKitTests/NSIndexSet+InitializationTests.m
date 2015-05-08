//
//  Created by Florian Mielke on 15.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSIndexSet+Initialization.h"


@interface NSIndexSetInitializationAdditionsTests : XCTestCase

@end


@implementation NSIndexSetInitializationAdditionsTests


#pragma mark -
#pragma mark Creation

- (void)testReturnsEmptyIndexSetForNilArray
{
    XCTAssertEqual([[NSIndexSet indexSetWithArray:nil] count], (NSUInteger)0);
}


- (void)testReturnsEmptyIndexSetForEmtptyArray
{
    XCTAssertEqual([[NSIndexSet indexSetWithArray:[NSArray array]] count], (NSUInteger)0);
}


- (void)testReturnsEmptyIndexSetForInvalidArray
{
    // Given
    NSArray *anArray = [NSArray arrayWithObjects:@"Lorem", @"Ipsum", @2, nil];
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:2];
    
    // Then
    XCTAssertTrue([[NSIndexSet indexSetWithArray:anArray] isEqualToIndexSet:indexes]);
}


- (void)testReturnsIndexSetWithIndexes
{
    // Given
    NSArray *anArray = [NSArray arrayWithObjects:@1, @2, @4, nil];
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    [indexes addIndex:1];
    [indexes addIndex:2];
    [indexes addIndex:4];
    
    // Then
    XCTAssertTrue([[NSIndexSet indexSetWithArray:anArray] isEqualToIndexSet:indexes]);
}


@end
