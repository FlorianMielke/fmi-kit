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

- (void)tearDown {
    self.sut = nil;
    self.mockTableView = nil;
    self.indexPath = nil;

    [super tearDown];
}

#pragma mark - Initialization

- (void)testControllerShouldBeInitilialized {
    XCTAssertNotNil(self.sut);
}

- (void)testControllerShouldNotBeInitializedWithInit {
    XCTAssertThrows([[FMIDatePickerController alloc] init]);
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
    XCTAssertEqual([self.sut estimatedHeightForDatePickerRow], (CGFloat)0.0);
}

#pragma mark - Delegate

- (void)testControllerShouldNotAcceptNonConformingObjectAsDelegate {
    id delegate = (id<FMIDatePickerControllerDelegate>)[NSNull null];
    XCTAssertThrows([self.sut setDelegate:delegate]);
}

- (void)testControllerShouldAcceptConformingObjectAsDelegate {
    id delegate = [OCMockObject mockForProtocol:@protocol(FMIDatePickerControllerDelegate)];
    XCTAssertNoThrow([self.sut setDelegate:delegate]);
}

- (void)testControllerShouldAcceptNilAsADelegate {
    XCTAssertNoThrow([self.sut setDelegate:nil]);
}

//- (void)testControllerShouldInformDelegateWhenDatePickerIsShown
//{
//
//    id mockDelegate = [OCMockObject mockForProtocol:@protocol(FMIDatePickerControllerDelegate)];
//    [[mockDelegate expect] datePickerControllerWillShowDatePicker:self.sut];
//    [[[mockDelegate expect] andReturn:nil] compoundControllerForDatePickerController:self.sut];
//    [[mockDelegate expect] datePickerControllerDidShowDatePicker:self.sut];
//
//    [self.sut setDelegate:mockDelegate];
//
//    // When
//    [self.sut toggleDatePicker];
//
//    // Then
//    XCTAssertNoThrow([mockDelegate verify]);
//}
//
//
//- (void)testControllerShouldInformDelegateWhenDatePickerIsHiddden
//{
//
//    [self.sut toggleDatePicker];
//
//    id mockDelegate = [OCMockObject mockForProtocol:@protocol(FMIDatePickerControllerDelegate)];
//    [[mockDelegate expect] datePickerControllerWillHideDatePicker:self.sut];
//    [[mockDelegate expect] datePickerControllerDidHideDatePicker:self.sut];
//
//    [self.sut setDelegate:mockDelegate];
//
//    // When
//    [self.sut toggleDatePicker];
//
//    // Then
//    XCTAssertNoThrow([mockDelegate verify]);
//}
//
//
//
//#pragma mark - Apperance
//
//- (void)testControllerShouldShowDatePickerWhenToggleOnce
//{
//    // When
//    [self.sut toggleDatePicker];
//
//    // Then
//    XCTAssertTrue([self.sut showsDatePicker]);
//}
//
//
//- (void)testControllerShouldHideDatePickerWhenToggleTwice
//{
//    // When
//    [self.sut toggleDatePicker];
//    [self.sut toggleDatePicker];
//
//    // Then
//    XCTAssertFalse([self.sut showsDatePicker]);
//}
//
//
//- (void)testControllerShouldForceTableViewToUpdateWhenToggle
//{
//
//    [[self.mockTableView expect] beginUpdates];
//    [[self.mockTableView expect] endUpdates];
//
//    // When
//    [self.sut toggleDatePicker];
//
//    // Then
//    XCTAssertNoThrow([self.mockTableView verify]);
//}
//
//
//- (void)testControllerShouldLoadDatePickerWhenToggleOnce
//{
//    // When
//    [self.sut toggleDatePicker];
//
//    // Then
//    XCTAssertNotNil([self.sut datePicker]);
//}
//
//
//- (void)testControllerShouldConfigureDatePickerWhenToggleOnce
//{
//
//    [self.sut setDatePickerMode:UIDatePickerModeTime];
//
//    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:15];
//    [self.sut setTimeZone:timeZone];
//
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:15];
//    [self.sut setDate:date];
//
//    // When
//    [self.sut toggleDatePicker];
//
//    // Then
//    XCTAssertEqual([[self.sut datePicker] datePickerMode], UIDatePickerModeTime);
//    XCTAssertEqual([[self.sut datePicker] timeZone], timeZone);
//    XCTAssertEqualObjects([[self.sut datePicker] date], date);
//    XCTAssertEqualObjects([[[self.sut datePicker] actionsForTarget:self.sut forControlEvent:UIControlEventValueChanged] firstObject], @"datePickerDidChange:");
//}
//
//
//- (void)testControllerShouldReturnAnEstimatedHeightOfDatePickerHeightWhenToggleOnce
//{
//    // When
//    [self.sut toggleDatePicker];
//
//    // Then
//    XCTAssertEqual([self.sut estimatedHeightForDatePickerRow], [[self.sut datePicker] frame].size.height);
//}
//
//
//- (void)testControllerShouldReturnAnEstimatedHeightOf0HeightWhenToggleTwice
//{
//
//    [self.sut toggleDatePicker];
//
//    // When
//    [self.sut toggleDatePicker];
//
//    // Then
//    XCTAssertEqual([self.sut estimatedHeightForDatePickerRow], (CGFloat)0.0);
//}
//
//
//- (void)testControllerShouldToggleDatePickerOfCompoundController
//{
//
//    id mockCompoundController1 = [OCMockObject niceMockForClass:[FMIDatePickerController class]];
//    [[[mockCompoundController1 stub] andReturnValue:@YES] showsDatePicker];
//    [[mockCompoundController1 expect] setShowsDatePicker:NO];
//
//    FakeDatePickerControllerDelegate *fakeDelegate = [[FakeDatePickerControllerDelegate alloc] init];
//    [fakeDelegate setCompoundController:@[mockCompoundController1, self.sut]];
//
//    [self.sut setDelegate:fakeDelegate];
//
//    // When
//    [self.sut toggleDatePicker];
//
//    // Then
//    XCTAssertTrue([self.sut showsDatePicker]);
//    XCTAssertNoThrow([mockCompoundController1 verify]);
//}

#pragma mark - Validation

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

#pragma mark - Post configuration

//- (void)testControllerShouldUpdateDatePickerModeAfterShowingDatePicker
//{
//
//    [self.sut toggleDatePicker];
//
//    // When
//    [self.sut setDatePickerMode:UIDatePickerModeTime];
//
//    // Then
//    XCTAssertEqual([[self.sut datePicker] datePickerMode], UIDatePickerModeTime);
//}
//
//
//- (void)testControllerShouldUpdateDatePickerDateAfterShowingDatePicker
//{
//
//    [self.sut toggleDatePicker];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:15];
//
//    // When
//    [self.sut setDate:date];
//
//    // Then
//    XCTAssertEqualObjects([[self.sut datePicker] date], date);
//}
//
//
//- (void)testControllerShouldUpdateDatePickerTimeZoneAfterShowingDatePicker
//{
//
//    [self.sut toggleDatePicker];
//    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:45];
//
//    // When
//    [self.sut setTimeZone:timeZone];
//
//    // Then
//    XCTAssertTrue([[[self.sut datePicker] timeZone] isEqualToTimeZone:timeZone]);
//}
//
//
//
//#pragma mark - Date changing
//
//- (void)testControllerShouldInformDelegateWhenDatePickerChanged
//{
//
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
//
//    id mockDelegate = [OCMockObject mockForProtocol:@protocol(FMIDatePickerControllerDelegate)];
//    [[mockDelegate expect] datePickerController:self.sut didChangeDate:date];
//
//    [self.sut setDelegate:mockDelegate];
//
//    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
//    [datePicker setDate:date];
//
//    // When
//    [self.sut datePickerDidChange:datePicker];
//
//    // Then
//    XCTAssertNoThrow([mockDelegate verify]);
//}

@end
