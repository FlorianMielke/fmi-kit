//
//  Created by Florian Mielke on 28.03.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "FMIActivityAlertView.h"


@interface FMIActivityAlertViewTests : XCTestCase

@property (nonatomic, strong) FMIActivityAlertView *alertView;
@property (nonatomic, strong) id mockDelegate;

@end



@implementation FMIActivityAlertViewTests

#pragma mark -
#pragma mark Fixture

- (void)setUp
{
    [super setUp];
    
    _mockDelegate = [OCMockObject mockForProtocol:@protocol(UIAlertViewDelegate)];
    [[[self mockDelegate] expect] willPresentAlertView:[OCMArg any]];
    
    _alertView = [[FMIActivityAlertView alloc] initWithTitle:@"Title" delegate:[self mockDelegate]];
}


- (void)tearDown
{
    [self setMockDelegate:nil];
    [self setAlertView:nil];
    
    [super tearDown];
}


#pragma mark -
#pragma mark Initializing

- (void)testAlertViewIsInitialized
{
    XCTAssertNotNil([self alertView]);
}


- (void)testAlertViewHasATitleAfterInitialization
{
    XCTAssertEqualObjects([[self alertView] title], @"Title");
}


- (void)testAlertViewHasADelegateAfterInitialization
{
    XCTAssertEqualObjects([[self alertView] delegate], [self mockDelegate]);
}


- (void)testAlertViewHasAnActivitiyIndicatorAfterInitialization
{
    XCTAssertNotNil([[self alertView] activityIndicatorView]);
}



#pragma mark -
#pragma mark Activity indicator

- (void)testActivityIndicatorIsSubviewOfAlertView
{
    // Given
    UIActivityIndicatorView *activityIndicatorView = [[self alertView] activityIndicatorView];
    
    // Then
    XCTAssertTrue([[[self alertView] subviews] containsObject:activityIndicatorView]);
}


//- (void)testActivitiyIndicatorStartedAnimatingWhenAlertViewIsShown
//{
//    // When
//    [[self alertView] show];
//    
//    // Then
//    XCTAssertTrue([[[self alertView] activityIndicatorView] isAnimating]);
//}


@end
