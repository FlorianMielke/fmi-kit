//
//  Created by Florian Mielke on 27.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMIImagePickerController.h"

@interface FMImagePickerControllerTests : XCTestCase

@property(NS_NONATOMIC_IOSONLY) FMIImagePickerController *subject;
@property(NS_NONATOMIC_IOSONLY) UIActionSheet *actionSheet;

@end

@implementation FMImagePickerControllerTests

- (void)setUp {
    [super setUp];
    self.subject = [[FMIImagePickerController alloc] init];
    self.actionSheet = [self.subject actionSheetForImage:nil];
}

- (void)testActionSheetBuilderIsInitialized {
    XCTAssertNotNil(self.subject);
}

- (void)testActionSheetIsInitialized {
    XCTAssertNotNil(self.actionSheet);
}

- (void)testActionSheetHasControllerAsDelegate {
    XCTAssertEqualObjects(self.subject, self.actionSheet.delegate);
}

- (void)testNumberOfButtonsIs2ForNoImage {
    XCTAssertEqual(2, self.actionSheet.numberOfButtons);
}

- (void)testNumberOfButtonIs4ForImage {
    UIImage *image = [[UIImage alloc] init];
    UIActionSheet *actionSheet = [self.subject actionSheetForImage:image];
    XCTAssertEqual(3, actionSheet.numberOfButtons);
}

- (void)testNumberOfButtonsIs3ForImagePickerAvailable {
    id mockImagePickerController = OCMClassMock([UIImagePickerController class]);
    OCMStub([mockImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]).andReturn(YES);

    UIActionSheet *actionSheet = [self.subject actionSheetForImage:nil];

    XCTAssertEqual(3, actionSheet.numberOfButtons);
}

- (void)testNumberOfButtonIs4ForImageAndImagePickerAvailable {
    id mockImagePickerController = OCMClassMock([UIImagePickerController class]);
    OCMStub([mockImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]).andReturn(YES);
    UIImage *image = [[UIImage alloc] init];

    UIActionSheet *actionSheet = [self.subject actionSheetForImage:image];

    XCTAssertEqual(4, actionSheet.numberOfButtons);
}

@end
