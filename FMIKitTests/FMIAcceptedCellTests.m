//
//  Created by Florian Mielke on 01.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMIAcceptedCell.h"

@interface FMIAcceptedCellTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIAcceptedCell *subject;

@end

@implementation FMIAcceptedCellTests

- (void)setUp {
    [super setUp];
    self.subject = [[FMIAcceptedCell alloc] init];
}

- (void)tearDown {
    self.subject = nil;
    [super tearDown];
}

- (void)testAcceptingCellChecksIt {
    self.subject.accepted = YES;

    XCTAssertEqual(self.subject.accessoryType, UITableViewCellAccessoryCheckmark);
}

- (void)testResetAcceptedCellUnchecksIt {
    self.subject.accepted = YES;
    self.subject.accepted = NO;

    XCTAssertEqual(self.subject.accessoryType, UITableViewCellAccessoryNone);
}

@end
