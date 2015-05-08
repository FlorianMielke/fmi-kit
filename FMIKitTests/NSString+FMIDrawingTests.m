//
//  Created by Florian Mielke on 07.11.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSString+FMIDrawing.h"


@interface NSString_FMIDrawingTests : XCTestCase

@end



@implementation NSString_FMIDrawingTests


- (void)testStringShouldReturnZeroSizeForNilAttributes
{
    // Given
    NSString *text = @"";
    
    // When
    CGSize size = [text fm_sizeWithAttributes:nil constraintToWidth:0.0];
    
    // Then
    XCTAssertTrue(CGSizeEqualToSize(size, CGSizeZero));
}


- (void)testStringShouldReturnSizeOfString
{
    // Given
    NSString *text = @"Lorem ipsum";
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10.0]};
    CGSize constraint = CGSizeMake(150.0, CGFLOAT_MAX);
    
    CGRect boundingRect = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    CGSize givenSize = CGSizeMake(ceil(boundingRect.size.width), ceil(boundingRect.size.height));
    
    // When
    CGSize size = [text fm_sizeWithAttributes:attributes constraintToWidth:constraint.width];
    
    // Then
    XCTAssertTrue(CGSizeEqualToSize(size, givenSize));
}


@end
