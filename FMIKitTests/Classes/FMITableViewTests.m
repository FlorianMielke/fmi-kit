//
//  Created by Florian Mielke on 21.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMITableView.h"
#import "FakeTableViewDataSource.h"

@interface FMITableViewTests : XCTestCase

@property(NS_NONATOMIC_IOSONLY) FMITableView *subject;
@property(NS_NONATOMIC_IOSONLY) FakeTableViewDataSource *dataSource;

@end

@implementation FMITableViewTests

- (void)setUp {
    [super setUp];
    self.subject = [[FMITableView alloc] init];
    [self.subject setAllowsAllRowsSelectionDuringEditing:YES];
    self.dataSource = [[FakeTableViewDataSource alloc] init];
    [self.subject setDataSource:self.dataSource];
}

- (void)testTableShouldBeInitialized {
    XCTAssertNotNil(self.subject);
}

- (void)testTableViewShouldBeConfigured {
    XCTAssertTrue([self.subject allowsAllRowsSelectionDuringEditing]);
    XCTAssertTrue([self.subject allowsMultipleSelectionDuringEditing]);
}

- (void)testTableViewShouldSelectAllRows {
    id delegate = OCMProtocolMock(@protocol(FMITableViewDelegate));
    OCMStub([delegate tableView:self.subject willSelectRowAtIndexPath:[OCMArg any]]).andReturn([OCMArg any]);
    self.subject.delegate = delegate;
    self.subject.editing = YES;

    [self.subject selectAllRows];

    XCTAssertEqual((NSUInteger) 30, self.subject.indexPathsForSelectedRows.count);
    XCTAssertTrue(self.subject.hasSelectedAllRows);
    OCMVerify([delegate tableView:self.subject didSelectRowAtIndexPath:[OCMArg any]]);
    OCMVerify([delegate tableViewDidSelectAllRows:self.subject]);
}

- (void)testTableViewShouldDeselectAllRows {
    id delegate = OCMProtocolMock(@protocol(FMITableViewDelegate));
    OCMStub([delegate tableView:self.subject willSelectRowAtIndexPath:[OCMArg any]]).andReturn([OCMArg any]);
    self.subject.editing = YES;
    [self.subject selectAllRows];
    self.subject.delegate = delegate;

    [self.subject deselectAllRows];

    XCTAssertEqual((NSUInteger) 0, self.subject.indexPathsForSelectedRows.count);
    XCTAssertFalse(self.subject.hasSelectedAllRows);
    OCMVerify([delegate tableView:self.subject didDeselectRowAtIndexPath:[OCMArg any]]);
    OCMVerify([delegate tableViewDidDeselectAllRows:self.subject]);
}

- (void)testTableViewShouldResetSelectionAttributesWhenDisableEditMode {
    self.subject.editing = YES;
    [self.subject selectAllRows];

    self.subject.editing = NO;

    XCTAssertFalse(self.subject.hasSelectedAllRows);
    XCTAssertEqual(self.subject.indexPathsForSelectedRows.count, (NSUInteger) 0);
}

- (void)testTableViewShouldResetSelectionAttributesWhenDisableEditModeAnimated {
    [self.subject setEditing:YES animated:NO];
    [self.subject selectAllRows];

    [self.subject setEditing:NO animated:NO];

    XCTAssertFalse(self.subject.hasSelectedAllRows);
    XCTAssertEqual(self.subject.indexPathsForSelectedRows.count, (NSUInteger) 0);
}

@end
