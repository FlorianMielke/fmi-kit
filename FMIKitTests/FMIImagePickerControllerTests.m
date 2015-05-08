//
//  Created by Florian Mielke on 27.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "FMIImagePickerController.h"


@interface FMImagePickerControllerTests : XCTestCase

@property (nonatomic, strong) FMIImagePickerController *sut;
@property (nonatomic, strong) UIActionSheet *actionSheet;

@end



@implementation FMImagePickerControllerTests


#pragma mark -
#pragma mark Fixture

- (void)setUp
{
    [super setUp];
    
    _sut = [[FMIImagePickerController alloc] init];
    _actionSheet = [[self sut] actionSheetForImage:nil];
}

- (void)tearDown
{
    _sut = nil;
    
    [super tearDown];
}



#pragma mark -
#pragma mark Initialization

- (void)testActionSheetBuilderIsInitialized
{
    XCTAssertNotNil([self sut]);
}


- (void)testActionSheetIsInitialized
{
    XCTAssertNotNil([self actionSheet]);
}


- (void)testActionSheetHasControllerAsDelegate
{
    XCTAssertEqualObjects([[self actionSheet] delegate], [self sut]);
}


- (void)testNumberOfButtonsIs2ForNoImage
{
    XCTAssertEqual([[self actionSheet] numberOfButtons], 2);
}


- (void)testNumberOfButtonIs4ForImage
{
    // Given
    UIImage *image = [[UIImage alloc] init];
    
    // When
    UIActionSheet *actionSheet = [[self sut] actionSheetForImage:image];
    
    // When
    XCTAssertEqual([actionSheet numberOfButtons], 3);
}


- (void)testNumberOfButtonsIs3ForImagePickerAvailable
{
    // Given
    id mockImagePickerController = [OCMockObject mockForClass:[UIImagePickerController class]];
    [[[mockImagePickerController stub] andReturnValue:@YES] isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    // When
    UIActionSheet *actionSheet = [[self sut] actionSheetForImage:nil];
    
    // Then
    XCTAssertEqual([actionSheet numberOfButtons], 3);
    [mockImagePickerController stopMocking];
}


- (void)testNumberOfButtonIs4ForImageAndImagePickerAvailable
{
    // Given
    id mockImagePickerController = [OCMockObject mockForClass:[UIImagePickerController class]];
    [[[mockImagePickerController stub] andReturnValue:@YES] isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];

    UIImage *image = [[UIImage alloc] init];
    
    // When
    UIActionSheet *actionSheet = [[self sut] actionSheetForImage:image];
    
    // When
    XCTAssertEqual([actionSheet numberOfButtons], 4);
    [mockImagePickerController stopMocking];
}


@end
