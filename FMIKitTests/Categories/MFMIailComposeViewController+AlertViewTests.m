//
//  Created by Florian Mielke on 19.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMIKitPrivates.h"
#import "MFMailComposeViewController+AlertView.h"


@interface MFMailComposeViewController_AlertViewTests : XCTestCase

@end


@implementation MFMailComposeViewController_AlertViewTests


#pragma mark -
#pragma mark Sending mail failed

- (void)testCannotSendMailReturnsAnAlertView
{
    // When
    id alertView = [MFMailComposeViewController cannotSendMailAlertView];
    
    XCTAssertTrue([alertView isKindOfClass:[UIAlertView class]]);
}


- (void)testCannotSendMailAlertViewHasNoDelegate
{
    XCTAssertNil([[MFMailComposeViewController cannotSendMailAlertView] delegate]);
}


- (void)testCannotSendMailAlertViewHasOnlyOneButton
{
    XCTAssertEqual([[MFMailComposeViewController cannotSendMailAlertView] numberOfButtons], 1);
}


- (void)testCannotSendMailAlertViewHasAnOKButton
{
    // When
    NSString *okButtonTitle = [[MFMailComposeViewController cannotSendMailAlertView] buttonTitleAtIndex:0];
    
    XCTAssertTrue([okButtonTitle isEqualToString:NSLocalizedStringFromTableInBundle(@"OK", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for word")]);
}



#pragma mark -
#pragma mark Sending mail failed

- (void)testSendingMailFailedReturnsAnAlertView
{
    // When
    id alertView = [MFMailComposeViewController sendingMailFailedAlertView];
    
    XCTAssertTrue([alertView isKindOfClass:[UIAlertView class]]);
}


- (void)testSendingMailFailedAlertViewHasNoDelegate
{
    XCTAssertNil([[MFMailComposeViewController sendingMailFailedAlertView] delegate]);
}


- (void)testSendingMailFailedAlertViewHasOnlyOneButton
{
    XCTAssertEqual([[MFMailComposeViewController sendingMailFailedAlertView] numberOfButtons], 1);
}


- (void)testSendingMailFailedAlertViewHasAnOKButton
{
    // When
    NSString *okButtonTitle = [[MFMailComposeViewController sendingMailFailedAlertView] buttonTitleAtIndex:0];
    
    XCTAssertTrue([okButtonTitle isEqualToString:NSLocalizedStringFromTableInBundle(@"OK", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for word")]);
}


@end
