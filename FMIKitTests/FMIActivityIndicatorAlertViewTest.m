//
//  Created by Florian Mielke on 09.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

@import XCTest;
#import "FMIActivityIndicatorAlertView.h"
#import <OCMock/OCMock.h>

@interface FMIActivityIndicatorAlertViewTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIActivityIndicatorAlertView *alertView;
@property (NS_NONATOMIC_IOSONLY) id alertControllerMock;
@property (NS_NONATOMIC_IOSONLY) id alertControllerViewMock;
@property (NS_NONATOMIC_IOSONLY) id activityIndicatorViewMock;
@property (NS_NONATOMIC_IOSONLY) id viewControllerMock;

@end

@implementation FMIActivityIndicatorAlertViewTest

- (void)setUp {
    [super setUp];
    self.viewControllerMock = OCMClassMock([UIViewController class]);
    self.alertControllerMock = OCMClassMock([UIAlertController class]);
    self.alertControllerViewMock = OCMClassMock([UIView class]);
    self.activityIndicatorViewMock = OCMClassMock([UIActivityIndicatorView class]);
    OCMStub([self.alertControllerMock view]).andReturn(self.alertControllerViewMock);
    OCMStub([self.alertControllerMock preferredStyle]).andReturn(UIAlertControllerStyleAlert);

    self.alertView = [[FMIActivityIndicatorAlertView alloc] initWithAlertController:self.alertControllerMock activityIndicatorView:self.activityIndicatorViewMock];
}

- (void)testAlertViewIsInitialized {
    XCTAssertNotNil(self.alertView);
}

- (void)testInitializeWithoutAttributes_fails {
    XCTAssertNil([[FMIActivityIndicatorAlertView alloc] initWithAlertController:nil activityIndicatorView:nil]);
    XCTAssertNil([[FMIActivityIndicatorAlertView alloc] initWithAlertController:self.alertControllerMock activityIndicatorView:nil]);
    XCTAssertNil([[FMIActivityIndicatorAlertView alloc] initWithAlertController:nil activityIndicatorView:self.activityIndicatorViewMock]);
}

- (void)testInitializeWithAlertControllerStyleActionSheet_fails {
    id actionSheetAlertControllerMock = OCMClassMock([UIAlertController class]);
    OCMStub([actionSheetAlertControllerMock preferredStyle]).andReturn(UIAlertControllerStyleActionSheet);
    XCTAssertNil([[FMIActivityIndicatorAlertView alloc] initWithAlertController:actionSheetAlertControllerMock activityIndicatorView:self.activityIndicatorViewMock]);
}

- (void)testSetTitle_setsAlertControllerTitle {
    self.alertView.title = @"Title";
    OCMVerify([self.alertControllerMock setTitle:@"Title"]);
}

- (void)testPresentAlertViewWithoutViewController_fails {
    XCTAssertThrows([self.alertView presentInViewController:nil]);
}

- (void)testPresentAlertView_addsActivityIndicatorToAlertController {
    [self.alertView presentInViewController:self.viewControllerMock];
    OCMVerify([self.alertControllerViewMock addSubview:self.activityIndicatorViewMock]);
    OCMVerify([self.viewControllerMock presentViewController:self.alertControllerMock animated:YES completion:nil]);
}

- (void)testPresentAlertViewTwice_doesNotAddActivityIndicatorToAlertControllerTwice {
    OCMStub([self.activityIndicatorViewMock superview]).andReturn(self.alertControllerViewMock);
    OCMExpect([self.alertControllerViewMock addSubview:self.activityIndicatorViewMock]);

    [self.alertView presentInViewController:self.viewControllerMock];

    XCTAssertThrows([self.alertControllerViewMock verify]);
    OCMVerify([self.viewControllerMock presentViewController:self.alertControllerMock animated:YES completion:nil]);
}

- (void)testDismissAlertView_dismissesViewController {
    [self.alertView dismiss];
    OCMVerify([self.alertControllerMock dismissViewControllerAnimated:YES completion:nil]);
}

@end
