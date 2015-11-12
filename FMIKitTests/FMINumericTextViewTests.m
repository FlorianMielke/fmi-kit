//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMINumericTextView.h"
#import <OCMock/OCMock.h>
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

- (void)DISABLED_testTextViewShouldShowKeyboard {
	id textViewMock = OCMPartialMock(self.textView);
	[self.textView toggleKeyboard];
	OCMVerify([textViewMock becomeFirstResponder]);
	XCTAssertTrue([self.textView showsKeyboard]);
}

- (void)DISABLED_testTextViewShouldHideKeyboard {
	id textViewMock = OCMPartialMock(self.textView);
	[self.textView toggleKeyboard];
	OCMVerify([textViewMock becomeFirstResponder]);
	[self.textView toggleKeyboard];

	XCTAssertFalse([self.textView showsKeyboard]);
	OCMVerify([textViewMock resignFirstResponder]);
}

- (void)testTextViewShouldToggleCompoundTextViews {
	id mockTextView1 = [OCMockObject niceMockForClass:[FMINumericTextView class]];
	[[[mockTextView1 stub] andReturnValue:@YES] showsKeyboard];
	[[mockTextView1 expect] setShowsKeyboard:NO];
	FakeTextViewDelegate *fakeDelegate = [[FakeTextViewDelegate alloc] init];
	[fakeDelegate setCompoundTextViews:@[mockTextView1, self.textView]];
	[self.textView setDelegate:fakeDelegate];

	[self.textView toggleKeyboard];

	XCTAssertTrue([self.textView showsKeyboard]);
	XCTAssertNoThrow([mockTextView1 verify]);
}

@end
