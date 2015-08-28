//
//  UIColor+SystemDefaultsTests.m
//
//  Created by Florian Mielke on 09.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+SystemDefaults.h"

@interface UIColor_SystemDefaultsTests : XCTestCase


@end



@implementation UIColor_SystemDefaultsTests


- (void)testColorShouldHaveDefaultCellDefaultStyleDetailLabelColor
{
    CGColorRef color = [[UIColor colorWithRed:0.557 green:0.557 blue:0.576 alpha:1.0] CGColor];
    XCTAssertTrue(CGColorEqualToColor([[UIColor cellDefaultStyleDetailLabelColor] CGColor], color));
}


@end
