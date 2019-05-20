#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

/**
 * This category adds methods to NSString to simplify the drawing of strings and to compute the bounding box of a string prior to drawing.
 */
@interface NSString (FMIDrawing)

/**
 * Returns the size of the string if it were rendered with the specified constraints.
 * @param attributes A dictionary of text attributes to be applied to the string.
 * @param width      The maximum acceptable width for the string.
 * @return The width and height of the resulting string’s bounding box. These values may be rounded up to the nearest whole number.
 */
- (CGSize)fm_sizeWithAttributes:(NSDictionary *)attributes constraintToWidth:(CGFloat)width;

@end
