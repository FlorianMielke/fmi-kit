//
//  NSIndexPath+ComparingTests.m
//
//  Created by Florian Mielke on 06.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
@import UIKit;
#import "NSIndexPath+Comparing.h"


@interface NSIndexPath_ComparingTests : XCTestCase

@property (nonatomic, strong) NSIndexPath *sut;

@end



@implementation NSIndexPath_ComparingTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];
    
    self.sut = [NSIndexPath indexPathForRow:0 inSection:0];
}


- (void)tearDown
{
    self.sut = nil;
    
    [super tearDown];
}



#pragma mark - Tests

- (void)testComparingIndexPathShouldSucceedForSameIndexPath
{
    // Given
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    // Then
    XCTAssertTrue([self.sut fm_isEqualToIndexPath:indexPath]);
}


- (void)testComparingIndexPathShouldFailForNonIndexPath
{
    XCTAssertFalse([self.sut fm_isEqualToIndexPath:(NSIndexPath *)[NSNull null]]);
}


- (void)testComparingIndexPathShouldFailForDifferentIndexPath
{
    // Given
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    
    // Then
    XCTAssertFalse([self.sut fm_isEqualToIndexPath:indexPath]);
}


@end
