//
//  Created by Florian Mielke on 27.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "FMIImagePickerController.h"


@interface FMImagePickerControllerTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIImagePickerController *sut;
@property (NS_NONATOMIC_IOSONLY) UIActionSheet *actionSheet;

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

    UIImage *image = [[UIImage alloc] init];
    
    UIActionSheet *actionSheet = [[self sut] actionSheetForImage:image];
    
    XCTAssertEqual([actionSheet numberOfButtons], 3);
}


- (void)testNumberOfButtonsIs3ForImagePickerAvailable
{

    id mockImagePickerController = [OCMockObject mockForClass:[UIImagePickerController class]];
    [[[mockImagePickerController stub] andReturnValue:@YES] isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    UIActionSheet *actionSheet = [[self sut] actionSheetForImage:nil];
    
    XCTAssertEqual([actionSheet numberOfButtons], 3);
    [mockImagePickerController stopMocking];
}


- (void)testNumberOfButtonIs4ForImageAndImagePickerAvailable
{

    id mockImagePickerController = [OCMockObject mockForClass:[UIImagePickerController class]];
    [[[mockImagePickerController stub] andReturnValue:@YES] isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];

    UIImage *image = [[UIImage alloc] init];
    
    UIActionSheet *actionSheet = [[self sut] actionSheetForImage:image];
    
    XCTAssertEqual([actionSheet numberOfButtons], 4);
    [mockImagePickerController stopMocking];
}


@end
