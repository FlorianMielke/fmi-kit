#import <XCTest/XCTest.h>
#import "NSString+FMIDrawing.h"

@interface NSString_FMIDrawingTests : XCTestCase

@end

@implementation NSString_FMIDrawingTests

- (void)testStringShouldReturnZeroSizeForNilAttributes{
  NSString *text = @"";
  
  CGSize size = [text fm_sizeWithAttributes:nil constraintToWidth:0.0];
  
  XCTAssertTrue(CGSizeEqualToSize(size, CGSizeZero));
}

- (void)testStringShouldReturnSizeOfString {
  NSString *text = @"Lorem ipsum";
  NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10.0]};
  CGSize constraint = CGSizeMake(150.0, CGFLOAT_MAX);
  CGRect boundingRect = [text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
  CGSize givenSize = CGSizeMake(ceil(boundingRect.size.width), ceil(boundingRect.size.height));
  
  CGSize size = [text fm_sizeWithAttributes:attributes constraintToWidth:constraint.width];
  
  XCTAssertTrue(CGSizeEqualToSize(size, givenSize));
}

@end
