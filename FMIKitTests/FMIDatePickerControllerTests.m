//
//  Created by Florian Mielke on 14.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMIDatePickerController.h"

@interface FMIDatePickerController (Test)

- (void)setShowsDatePicker:(BOOL)flag;

- (void)datePickerDidChange:(id)sender;

@end

@interface FMIDatePickerControllerTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIDatePickerController *sut;
@property (NS_NONATOMIC_IOSONLY) id mockTableView;
@property (NS_NONATOMIC_IOSONLY) NSIndexPath *indexPath;

@end

@implementation FMIDatePickerControllerTests

#pragma mark - Fixture

- (void)setUp {
    [super setUp];
    self.mockTableView = [OCMockObject niceMockForClass:[UITableView class]];
    self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.sut = [[FMIDatePickerController alloc] initWithTableView:self.mockTableView forIndexPath:self.indexPath];
}

- (void)testControllerShouldBeInitilialized {
    XCTAssertNotNil(self.sut);
}

- (void)testControllerShouldNotBeInitializedWithNilTableView {
    XCTAssertNil([[FMIDatePickerController alloc] initWithTableView:nil forIndexPath:self.indexPath]);
}

- (void)testControllerShouldNotBeInitializedWithNilIndexPath {
    XCTAssertNil([[FMIDatePickerController alloc] initWithTableView:self.mockTableView forIndexPath:nil]);
}

- (void)testControllerShouldReturnTheAssignedIndexPath {
    XCTAssertEqualObjects([self.sut indexPath], self.indexPath);
}

- (void)testControllerShouldReturnTheAssignedTableView {
    XCTAssertEqualObjects([self.sut tableView], self.mockTableView);
}

- (void)testControllerShouldReturnNilForDatePickerByDefault {
    XCTAssertNil([self.sut datePicker]);
}

- (void)testControllerShouldNotShowDatePickerByDefault {
    XCTAssertFalse([self.sut showsDatePicker]);
}

- (void)testControllerShouldReturnAnEstimatedHeightOf0ByDefault {
    XCTAssertEqual([self.sut estimatedHeightForDatePickerRow], (CGFloat) 0.0);
}

- (void)testControllerShouldNotAcceptNonConformingObjectAsDelegate {
    id delegate = (id <FMIDatePickerControllerDelegate>) [NSNull null];
    XCTAssertThrows([self.sut setDelegate:delegate]);
}

- (void)testControllerShouldAcceptConformingObjectAsDelegate {
    id delegate = [OCMockObject mockForProtocol:@protocol(FMIDatePickerControllerDelegate)];
    XCTAssertNoThrow([self.sut setDelegate:delegate]);
}

- (void)testControllerShouldAcceptNilAsADelegate {
    XCTAssertNoThrow([self.sut setDelegate:nil]);
}

- (void)testControllerShouldFailForRowValidationWithNilIndexPath {
    XCTAssertFalse([self.sut isDatePickerRowAtIndexPath:nil]);
}

- (void)testControllerShouldSucceedForRowValidationWithDatePickerIndexPath {
    XCTAssertTrue([self.sut isDatePickerRowAtIndexPath:[self.sut indexPath]]);
}

- (void)testControllerShouldFailRowValidationWithAnotherIndexPath {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:12 inSection:5];
    XCTAssertFalse([self.sut isDatePickerRowAtIndexPath:indexPath]);
}

@end
