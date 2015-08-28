//
//  UITableView+IndexPathTests.m
//
//  Created by Florian Mielke on 29.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UITableView+IndexPath.h"
#import "FakeTableViewDataSource.h"


@interface UITableView_IndexPathTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) UITableView *sut;
@property (NS_NONATOMIC_IOSONLY) FakeTableViewDataSource *dataSource;

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

    UITableView *table = [[UITableView alloc] init];
    
    XCTAssertTrue([table fm_isEmpty]);
}


- (void)testTableShouldReturnFirstIndexPath
{

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    XCTAssertEqual([[self.sut fm_firstIndexPath] compare:indexPath], NSOrderedSame);
}


- (void)testEmtpyTableShouldReturnNilForFirstIndexPath
{

    UITableView *table = [[UITableView alloc] init];
    
    XCTAssertNil([table fm_firstIndexPath]);
}


- (void)testTableShouldReturnLastIndexPath
{

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:2];
    
    XCTAssertEqual([[self.sut fm_lastIndexPath] compare:indexPath], NSOrderedSame);
}


- (void)testEmtpyTableShouldReturnNilForLastIndexPath
{

    UITableView *table = [[UITableView alloc] init];
    
    XCTAssertNil([table fm_lastIndexPath]);
}


- (void)testTableShouldReturnLastIndexPathOfFirstSection
{

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
    
    XCTAssertEqual([[self.sut fm_lastIndexPathInSection:0] compare:indexPath], NSOrderedSame);
}



#pragma mark - Enumeration

- (void)testTableViewShouldEnumerateIndexPaths
{

    __block NSInteger numberOfRows = 0;
    
    [self.sut fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        numberOfRows++;
    }];
    
    XCTAssertEqual(numberOfRows, 30);
}


- (void)testTableViewShouldPassIndexPathsDuringEnumeration
{

    __block NSIndexPath *lastIndexPath = nil;
    
    [self.sut fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        lastIndexPath = indexPath;
    }];
    
    XCTAssertTrue([lastIndexPath compare:[NSIndexPath indexPathForRow:9 inSection:2]] == NSOrderedSame);
}


- (void)testTableViewShouldStopEnumeration
{

    __block NSIndexPath *stoppedIndexPath = nil;
    NSIndexPath *stoppingIndexPath = [NSIndexPath indexPathForRow:4 inSection:1];
    
    [self.sut fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        
        stoppedIndexPath = indexPath;
        
        if ([stoppedIndexPath compare:stoppingIndexPath] == NSOrderedSame) {
            *stop = YES;
        }
        
    }];
    
    XCTAssertTrue([stoppedIndexPath compare:stoppingIndexPath] == NSOrderedSame);
}


@end
