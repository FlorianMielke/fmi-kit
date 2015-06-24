//
//  Created by Florian Mielke on 13.11.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMIComparator.h"


@interface FMIComparatorTests : XCTestCase

@end



@implementation FMIComparatorTests


- (void)testComparatorShouldReturnCorrectFormats
{
    XCTAssertEqualObjects([FMIComparator formatForType:FMIComparatorTypeEqualTo], @"%K == %@");
    XCTAssertEqualObjects([FMIComparator formatForType:FMIComparatorTypeNotEqualTo], @"%K != %@");
    XCTAssertEqualObjects([FMIComparator formatForType:FMIComparatorTypeGreaterThan], @"%K > %@");
    XCTAssertEqualObjects([FMIComparator formatForType:FMIComparatorTypeLessThan], @"%K < %@");
    XCTAssertEqualObjects([FMIComparator formatForType:FMIComparatorTypeGreaterThanOrEqualTo], @"%K >= %@");
    XCTAssertEqualObjects([FMIComparator formatForType:FMIComparatorTypeLessThanOrEqualTo], @"%K <= %@");
}


@end
