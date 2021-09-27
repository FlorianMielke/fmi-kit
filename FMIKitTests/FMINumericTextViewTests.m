//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMINumericTextView.h"
#import "FakeTextViewDelegate.h"

@interface FMINumericTextView (Testing)

- (void)setShowsKeyboard:(BOOL)flag;

@end

@interface FMINumericTextViewTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMINumericTextView *textView;

@end

@implementation FMINumericTextViewTests

- (void)setUp {
	[super setUp];
	self.textView = [FMINumericTextView new];
}

- (void)testTextViewShouldBeInitialized {
	XCTAssertNotNil(self.textView);
	XCTAssertEqual(self.textView.accessoryButtonType, FMINumericTextViewAccessoryButtonTypeNone);
	XCTAssertEqual([self.textView keyboardType], UIKeyboardTypeNumberPad);
}

- (void)testTextViewShouldNotShowKeyboardByDefault {
	XCTAssertFalse([self.textView showsKeyboard]);
}

@end
