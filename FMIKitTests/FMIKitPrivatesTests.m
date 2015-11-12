//
//  Created by Florian Mielke on 29.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMIKitPrivates.h"

@interface FMIKitPrivatesTests : XCTestCase

@end

@implementation FMIKitPrivatesTests

- (void)testFrameworkPrivateShouldReturnResourcesBundle {
    XCTAssertNotNil([FMIKitPrivates resourcesBundle]);
}

@end
