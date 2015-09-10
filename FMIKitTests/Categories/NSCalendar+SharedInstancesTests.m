//
//  Created by Florian Mielke on 29.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSCalendar+SharedInstances.h"

@interface NSCalendar_SharedInstancesTests : XCTestCase

@end

@implementation NSCalendar_SharedInstancesTests

- (void)testSharedCurrentCalendarShouldBeASingleton {
    XCTAssertNotNil([NSCalendar sharedCurrentCalendar]);
    XCTAssertEqual([NSCalendar sharedCurrentCalendar], [NSCalendar sharedCurrentCalendar]);
}

- (void)testSharedGMTCalendarShouldBeASingleton {
    XCTAssertNotNil([NSCalendar sharedGMTCalendar]);
    XCTAssertEqual([NSCalendar sharedGMTCalendar], [NSCalendar sharedGMTCalendar]);
}

@end
