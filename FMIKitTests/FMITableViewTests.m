//
//  Created by Florian Mielke on 21.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
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
