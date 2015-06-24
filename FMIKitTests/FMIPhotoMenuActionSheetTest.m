//
//  Created by Florian Mielke on 09.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMIPhotoMenuActionSheet.h"
#import <OCMock/OCMock.h>

@interface FMIPhotoMenuActionSheetTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIPhotoMenuActionSheet *actionSheet;
@property (NS_NONATOMIC_IOSONLY) id alertControllerMock;
@property (NS_NONATOMIC_IOSONLY) id delegateMock;

@end

@implementation FMIPhotoMenuActionSheetTest

- (void)setUp {
    [super setUp];
    self.alertControllerMock = OCMClassMock([UIAlertController class]);
    self.delegateMock = OCMProtocolMock(@protocol(FMIPhotoMenuActionSheetDelegate));
    self.actionSheet = [[FMIPhotoMenuActionSheet alloc] initWithAlertController:self.alertControllerMock delegate:self.delegateMock];
}

- (void)testActionSheetIsInitialized {
    XCTAssertNotNil(self.actionSheet);
}

- (void)testInitializeWithoutAlertControllerActionSheet_fails {
    XCTAssertNil([[FMIPhotoMenuActionSheet alloc] initWithAlertController:nil delegate:nil]);
    XCTAssertNil([[FMIPhotoMenuActionSheet alloc] initWithAlertController:nil delegate:self.delegateMock]);
}

- (void)testInitializeWithAlertControllerStyleAlert_fails {
    id alertStyleAlertControllerMock = OCMClassMock([UIAlertController class]);
    OCMStub([alertStyleAlertControllerMock preferredStyle]).andReturn(UIAlertControllerStyleAlert);
    XCTAssertNil([[FMIPhotoMenuActionSheet alloc] initWithAlertController:alertStyleAlertControllerMock delegate:self.delegateMock]);
}

- (void)testInitializeWithoutDelegate_succeeds {
    XCTAssertNotNil([[FMIPhotoMenuActionSheet alloc] initWithAlertController:self.alertControllerMock delegate:nil]);
}

- (void)testPresentActionSheetWithoutViewController_fails {
    XCTAssertThrows([self.actionSheet presentInViewController:nil]);
}

- (void)testPresentActionSheetWithGivenViewController_succeeds {
    id viewControllerMock = OCMClassMock([UIViewController class]);
    [self.actionSheet presentInViewController:viewControllerMock];
    OCMVerify([viewControllerMock presentViewController:self.alertControllerMock animated:YES completion:nil]);
}

- (void)testDismissActionSheet_dismissesViewController {
    [self.actionSheet dismiss];
    OCMVerify([self.alertControllerMock dismissViewControllerAnimated:YES completion:nil]);
}

@end
