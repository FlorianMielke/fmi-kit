//
//  NSUndoManager+GroupingTests.m
//
//  Created by Florian Mielke on 27.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "NSUndoManager+Grouping.h"


@interface NSUndoManager_GroupingTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) NSUndoManager *sut;

@end


@implementation NSUndoManager_GroupingTests


#pragma mark -
#pragma mark Fixture

- (void)setUp
{
    _sut = [[NSUndoManager alloc] init];
    [[self sut] setGroupsByEvent:NO];
    
    [super setUp];
}


- (void)tearDown
{
    [self setSut:nil];
    
    [super tearDown];
}



#pragma mark -
#pragma mark Grouping

- (void)testSavelyEndGroupingDoesEndTheLastOpenGroup
{

    id mockUndoManager = [OCMockObject partialMockForObject:[self sut]];
    
    NSInteger groupingLevel = 1;
    [[[mockUndoManager stub] andReturnValue:OCMOCK_VALUE(groupingLevel)] groupingLevel];
    [[mockUndoManager expect] endUndoGrouping];
    
    [[self sut] savelyEndUndoGrouping];
    
    XCTAssertNoThrow([mockUndoManager verify]);
}


- (void)testSavelyEndGroupingDoesNothingIfNoOpenGroup
{

    id mockUndoManager = [OCMockObject partialMockForObject:[self sut]];
    
    NSInteger groupingLevel = 0;
    [[[mockUndoManager stub] andReturnValue:OCMOCK_VALUE(groupingLevel)] groupingLevel];
    [[mockUndoManager reject] endUndoGrouping];
    
    [[self sut] savelyEndUndoGrouping];
    
    XCTAssertNoThrow([mockUndoManager verify]);
}


- (void)testSavelyBeginGroupingDoesOpenNewGroupIfNoOtherGroupIsOpen
{

    id mockUndoManager = [OCMockObject partialMockForObject:[self sut]];
    
    NSInteger groupingLevel = 0;
    [[[mockUndoManager stub] andReturnValue:OCMOCK_VALUE(groupingLevel)] groupingLevel];
    [[mockUndoManager expect] beginUndoGrouping];
    
    [[self sut] savelyBeginUndoGrouping];
    
    XCTAssertNoThrow([mockUndoManager verify]);
}


- (void)testSavelyBeginGroupingDoesNothingIfAnotherGroupIsOpen
{

    id mockUndoManager = [OCMockObject partialMockForObject:[self sut]];
    
    NSInteger groupingLevel = 1;
    [[[mockUndoManager stub] andReturnValue:OCMOCK_VALUE(groupingLevel)] groupingLevel];
    [[mockUndoManager reject] beginUndoGrouping];
    
    [[self sut] savelyBeginUndoGrouping];
    
    XCTAssertNoThrow([mockUndoManager verify]);
}



@end
