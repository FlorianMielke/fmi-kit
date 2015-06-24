//
//  UIImage+CreationTests.m
//
//  Created by Florian Mielke on 11.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "UIImage+Creation.h"


@interface UIImage_CreationTests : XCTestCase

@end


@implementation UIImage_CreationTests


- (void)testImageShouldBeCreatedWithColor
{
    // When
    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor]];
    
    XCTAssertNotNil(image);
    XCTAssertTrue(CGSizeEqualToSize([image size], CGSizeMake(1.0, 1.0)));
}

@end
