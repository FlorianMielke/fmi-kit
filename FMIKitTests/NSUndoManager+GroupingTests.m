//
//  NSUndoManager+GroupingTests.m
//
//  Created by Florian Mielke on 27.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "NSUndoManager+Grouping.h"


@interface NSUndoManager_GroupingTests : XCTestCase

@property (nonatomic, strong) NSUndoManager *sut;

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
    // Given
    id mockUndoManager = [OCMockObject partialMockForObject:[self sut]];
    
    NSInteger groupingLevel = 1;
    [[[mockUndoManager stub] andReturnValue:OCMOCK_VALUE(groupingLevel)] groupingLevel];
    [[mockUndoManager expect] endUndoGrouping];
    
    // When
    [[self sut] savelyEndUndoGrouping];
    
    // Then
    XCTAssertNoThrow([mockUndoManager verify]);
}


- (void)testSavelyEndGroupingDoesNothingIfNoOpenGroup
{
    // Given
    id mockUndoManager = [OCMockObject partialMockForObject:[self sut]];
    
    NSInteger groupingLevel = 0;
    [[[mockUndoManager stub] andReturnValue:OCMOCK_VALUE(groupingLevel)] groupingLevel];
    [[mockUndoManager reject] endUndoGrouping];
    
    // When
    [[self sut] savelyEndUndoGrouping];
    
    // Then
    XCTAssertNoThrow([mockUndoManager verify]);
}


- (void)testSavelyBeginGroupingDoesOpenNewGroupIfNoOtherGroupIsOpen
{
    // Given
    id mockUndoManager = [OCMockObject partialMockForObject:[self sut]];
    
    NSInteger groupingLevel = 0;
    [[[mockUndoManager stub] andReturnValue:OCMOCK_VALUE(groupingLevel)] groupingLevel];
    [[mockUndoManager expect] beginUndoGrouping];
    
    // When
    [[self sut] savelyBeginUndoGrouping];
    
    // Then
    XCTAssertNoThrow([mockUndoManager verify]);
}


- (void)testSavelyBeginGroupingDoesNothingIfAnotherGroupIsOpen
{
    // Given
    id mockUndoManager = [OCMockObject partialMockForObject:[self sut]];
    
    NSInteger groupingLevel = 1;
    [[[mockUndoManager stub] andReturnValue:OCMOCK_VALUE(groupingLevel)] groupingLevel];
    [[mockUndoManager reject] beginUndoGrouping];
    
    // When
    [[self sut] savelyBeginUndoGrouping];
    
    // Then
    XCTAssertNoThrow([mockUndoManager verify]);
}



@end
