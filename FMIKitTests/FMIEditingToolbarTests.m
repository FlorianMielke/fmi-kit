//
//  Created by Florian Mielke on 03.11.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "FMIEditingToolbar.h"


@interface FMIEditingToolbarTests : XCTestCase

@property (nonatomic, strong) FMIEditingToolbar *sut;

@end



@implementation FMIEditingToolbarTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    self.sut = [[FMIEditingToolbar alloc] initWithFrame:CGRectZero];
}


- (void)tearDown
{
    self.sut = nil;
    
    [super tearDown];
}



#pragma mark - Tests

- (void)testToolbarShouldBeInitialized
{
    XCTAssertNotNil(self.sut);
}


- (void)testToolarShouldntBeInEditingModeByDefault
{
    XCTAssertFalse(self.sut.isEditing);
    XCTAssertNil(self.sut.defaultItems);
    XCTAssertNil(self.sut.editingItems);
}


- (void)testToolbarShouldShowDefaultItems
{
    // Given
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    self.sut.defaultItems = @[item];
    
    // When
    [self.sut setEditing:NO animated:NO];
    
    // Then
    XCTAssertEqualObjects(self.sut.defaultItems, self.sut.items);
    XCTAssertFalse(self.sut.isEditing);
}


- (void)testToolbarShouldShowEditingItems
{
    // Given
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] init];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] init];
    self.sut.editingItems = @[item1, item2];
    
    // When
    [self.sut setEditing:YES animated:NO];
    
    // Then
    XCTAssertEqualObjects(self.sut.editingItems, self.sut.items);
    XCTAssertTrue(self.sut.isEditing);
}


- (void)testToolbarShouldAssignEditButtonItemOfViewControllerWhenAwakeFromNib
{
    // Given
    UIViewController *controller = [[UIViewController alloc] init];
    self.sut.viewController = controller;
    
    // When
    [self.sut awakeFromNib];
    
    // Then
    XCTAssertEqualObjects(self.sut.editButtonItem, controller.editButtonItem);
}



@end
