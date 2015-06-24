//
//  Created by Florian Mielke on 21.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "FMITableView.h"
#import "FakeTableViewDataSource.h"


@interface FMITableViewTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMITableView *sut;
@property (NS_NONATOMIC_IOSONLY) FakeTableViewDataSource *dataSource;

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

    id mockDelegate = [OCMockObject niceMockForProtocol:@protocol(FMITableViewDelegate)];
    [[[mockDelegate stub] andReturn:[OCMArg any]] tableView:_sut willSelectRowAtIndexPath:[OCMArg any]];
    [[mockDelegate expect] tableView:_sut didSelectRowAtIndexPath:[OCMArg any]];
    [[mockDelegate expect] tableViewDidSelectAllRows:_sut];

    [_sut setDelegate:mockDelegate];
    
    [_sut setEditing:YES];
    [_sut selectAllRows];
    
    XCTAssertEqual([[_sut indexPathsForSelectedRows] count], (NSUInteger)30);
    XCTAssertTrue([_sut hasSelectedAllRows]);
    XCTAssertNoThrow([mockDelegate verify]);
}


- (void)testTableViewShouldDeselectAllRows
{

    [_sut setEditing:YES];
    [_sut selectAllRows];
    
    id mockDelegate = [OCMockObject niceMockForProtocol:@protocol(FMITableViewDelegate)];
    [[[mockDelegate stub] andReturn:[OCMArg any]] tableView:_sut willSelectRowAtIndexPath:[OCMArg any]];
    [[mockDelegate expect] tableView:_sut didDeselectRowAtIndexPath:[OCMArg any]];
    [[mockDelegate expect] tableViewDidDeselectAllRows:_sut];
    
    [_sut setDelegate:mockDelegate];
    
    [_sut deselectAllRows];
    
    XCTAssertEqual([[_sut indexPathsForSelectedRows] count], (NSUInteger)0);
    XCTAssertFalse([_sut hasSelectedAllRows]);
    XCTAssertNoThrow([mockDelegate verify]);
}


- (void)testTableViewShouldResetSelectionAttributesWhenDisableEditMode
{

    [_sut setEditing:YES];
    [_sut selectAllRows];
    
    [_sut setEditing:NO];
    
    XCTAssertFalse([_sut hasSelectedAllRows]);
    XCTAssertEqual([[_sut indexPathsForSelectedRows] count], (NSUInteger)0);
}


- (void)testTableViewShouldResetSelectionAttributesWhenDisableEditModeAnimated
{

    [_sut setEditing:YES animated:NO];
    [_sut selectAllRows];
    
    [_sut setEditing:NO animated:NO];
    
    XCTAssertFalse([_sut hasSelectedAllRows]);
    XCTAssertEqual([[_sut indexPathsForSelectedRows] count], (NSUInteger)0);
}




@end
