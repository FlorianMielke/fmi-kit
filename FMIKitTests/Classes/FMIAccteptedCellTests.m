//
//  Created by Florian Mielke on 01.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMIAcceptedCell.h"


@interface FMIAccteptedCellTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIAcceptedCell *sut;

@end



@implementation FMIAccteptedCellTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    _sut = [[FMIAcceptedCell alloc] init];
}


- (void)tearDown
{
    _sut = nil;
    
    [super tearDown];
}



#pragma mark - Initialization

- (void)testCellIsInitialized
{
    XCTAssertNotNil([self sut]);
}


- (void)testAcceptingCellChecksIt
{
    // When
    [[self sut] setAccepted:YES];
    
    XCTAssertEqual([[self sut] accessoryType], UITableViewCellAccessoryCheckmark);
}


- (void)testResetAcceptedCellUnchecksIt
{
    // When
    [[self sut] setAccepted:YES];
    [[self sut] setAccepted:NO];
    
    XCTAssertEqual([[self sut] accessoryType], UITableViewCellAccessoryNone);
}


@end
