#import "NSString+FMIDrawing.h"

@implementation NSString (FMIDrawing)

- (CGSize)fm_sizeWithAttributes:(NSDictionary *)attributes constraintToWidth:(CGFloat)width {
  if (attributes == nil) {
    return CGSizeZero;
  }
  CGSize size = CGSizeMake(width, CGFLOAT_MAX);
  CGRect boundingRect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
  return CGSizeMake(ceil(boundingRect.size.width), ceil(boundingRect.size.height));
}

@end
