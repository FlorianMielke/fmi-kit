//
//  UITableView+IndexPathTests.m
//
//  Created by Florian Mielke on 29.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "UITableView+IndexPath.h"
#import "FakeTableViewDataSource.h"


@interface UITableView_IndexPathTests : XCTestCase

@property (nonatomic) UITableView *sut;
@property (nonatomic) FakeTableViewDataSource *dataSource;

@end



@implementation UITableView_IndexPathTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    self.sut = [[UITableView alloc] init];
    
    self.dataSource = [[FakeTableViewDataSource alloc] init];
    [self.sut setDataSource:self.dataSource];
}

- (void)tearDown
{
    self.sut = nil;
    self.dataSource = nil;

    [super tearDown];
}



#pragma mark - Tests

- (void)testTableShouldReturnFalseForIsEmtpy
{
    XCTAssertFalse([self.sut fm_isEmpty]);
}


- (void)testEmtpyTableShouldReturnTrueForEmptyTable
{
    // Given
    UITableView *table = [[UITableView alloc] init];
    
    // Then
    XCTAssertTrue([table fm_isEmpty]);
}


- (void)testTableShouldReturnFirstIndexPath
{
    // Given
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    // Then
    XCTAssertEqual([[self.sut fm_firstIndexPath] compare:indexPath], NSOrderedSame);
}


- (void)testEmtpyTableShouldReturnNilForFirstIndexPath
{
    // Given
    UITableView *table = [[UITableView alloc] init];
    
    // Then
    XCTAssertNil([table fm_firstIndexPath]);
}


- (void)testTableShouldReturnLastIndexPath
{
    // Given
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:2];
    
    // Then
    XCTAssertEqual([[self.sut fm_lastIndexPath] compare:indexPath], NSOrderedSame);
}


- (void)testEmtpyTableShouldReturnNilForLastIndexPath
{
    // Given
    UITableView *table = [[UITableView alloc] init];
    
    // Then
    XCTAssertNil([table fm_lastIndexPath]);
}


- (void)testTableShouldReturnLastIndexPathOfFirstSection
{
    // Given
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
    
    // Then
    XCTAssertEqual([[self.sut fm_lastIndexPathInSection:0] compare:indexPath], NSOrderedSame);
}



#pragma mark - Enumeration

- (void)testTableViewShouldEnumerateIndexPaths
{
    // Given
    __block NSInteger numberOfRows = 0;
    
    // When
    [self.sut fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        numberOfRows++;
    }];
    
    // Then
    XCTAssertEqual(numberOfRows, 30);
}


- (void)testTableViewShouldPassIndexPathsDuringEnumeration
{
    // Given
    __block NSIndexPath *lastIndexPath = nil;
    
    // When
    [self.sut fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        lastIndexPath = indexPath;
    }];
    
    // Then
    XCTAssertTrue([lastIndexPath compare:[NSIndexPath indexPathForRow:9 inSection:2]] == NSOrderedSame);
}


- (void)testTableViewShouldStopEnumeration
{
    // Given
    __block NSIndexPath *stoppedIndexPath = nil;
    NSIndexPath *stoppingIndexPath = [NSIndexPath indexPathForRow:4 inSection:1];
    
    // When
    [self.sut fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        
        stoppedIndexPath = indexPath;
        
        if ([stoppedIndexPath compare:stoppingIndexPath] == NSOrderedSame) {
            *stop = YES;
        }
        
    }];
    
    // Then
    XCTAssertTrue([stoppedIndexPath compare:stoppingIndexPath] == NSOrderedSame);
}


@end
