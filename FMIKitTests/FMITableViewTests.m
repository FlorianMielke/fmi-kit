//
//  Created by Florian Mielke on 21.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "FMITableView.h"
#import "FakeTableViewDataSource.h"


@interface FMITableViewTests : XCTestCase

@property (nonatomic) FMITableView *sut;
@property (nonatomic) FakeTableViewDataSource *dataSource;

@end



@implementation FMITableViewTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    _sut = [[FMITableView alloc] init];
    [_sut setAllowsAllRowsSelectionDuringEditing:YES];
    
    _dataSource = [[FakeTableViewDataSource alloc] init];
    [_sut setDataSource:_dataSource];
}


- (void)tearDown
{
    _sut = nil;
    _dataSource = nil;
    
    [super tearDown];
}



#pragma mark - Initialization

- (void)testTableShouldBeInitialized
{
    XCTAssertNotNil(_sut);
}


- (void)testTableViewShouldBeConfigured
{
    XCTAssertTrue([_sut allowsAllRowsSelectionDuringEditing]);
    XCTAssertTrue([_sut allowsMultipleSelectionDuringEditing]);
}



#pragma mark - Selection

- (void)testTableViewShouldSelectAllRows
{
    // Given
    id mockDelegate = [OCMockObject niceMockForProtocol:@protocol(FMITableViewDelegate)];
    [[[mockDelegate stub] andReturn:[OCMArg any]] tableView:_sut willSelectRowAtIndexPath:[OCMArg any]];
    [[mockDelegate expect] tableView:_sut didSelectRowAtIndexPath:[OCMArg any]];
    [[mockDelegate expect] tableViewDidSelectAllRows:_sut];

    [_sut setDelegate:mockDelegate];
    
    // When
    [_sut setEditing:YES];
    [_sut selectAllRows];
    
    // Then
    XCTAssertEqual([[_sut indexPathsForSelectedRows] count], (NSUInteger)30);
    XCTAssertTrue([_sut hasSelectedAllRows]);
    XCTAssertNoThrow([mockDelegate verify]);
}


- (void)testTableViewShouldDeselectAllRows
{
    // Given
    [_sut setEditing:YES];
    [_sut selectAllRows];
    
    id mockDelegate = [OCMockObject niceMockForProtocol:@protocol(FMITableViewDelegate)];
    [[[mockDelegate stub] andReturn:[OCMArg any]] tableView:_sut willSelectRowAtIndexPath:[OCMArg any]];
    [[mockDelegate expect] tableView:_sut didDeselectRowAtIndexPath:[OCMArg any]];
    [[mockDelegate expect] tableViewDidDeselectAllRows:_sut];
    
    [_sut setDelegate:mockDelegate];
    
    // When
    [_sut deselectAllRows];
    
    // Then
    XCTAssertEqual([[_sut indexPathsForSelectedRows] count], (NSUInteger)0);
    XCTAssertFalse([_sut hasSelectedAllRows]);
    XCTAssertNoThrow([mockDelegate verify]);
}


- (void)testTableViewShouldResetSelectionAttributesWhenDisableEditMode
{
    // Given
    [_sut setEditing:YES];
    [_sut selectAllRows];
    
    // When
    [_sut setEditing:NO];
    
    // Then
    XCTAssertFalse([_sut hasSelectedAllRows]);
    XCTAssertEqual([[_sut indexPathsForSelectedRows] count], (NSUInteger)0);
}


- (void)testTableViewShouldResetSelectionAttributesWhenDisableEditModeAnimated
{
    // Given
    [_sut setEditing:YES animated:NO];
    [_sut selectAllRows];
    
    // When
    [_sut setEditing:NO animated:NO];
    
    // Then
    XCTAssertFalse([_sut hasSelectedAllRows]);
    XCTAssertEqual([[_sut indexPathsForSelectedRows] count], (NSUInteger)0);
}




@end
