//
//  UIImage+Resizing.h
//
//  Created by Florian Mielke on 16/6/11.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

@import UIKit;

/**
 *	This category adds methods to UIImage to improve scaling images.
 */
@interface UIImage (Resizing)

/**
 *	Returns a new image to fit a given size.
 *	@param	size	The size to fit.
 *	@return	A new image fit to a given size.
 */
- (UIImage *)scaledImageToFitSize:(CGSize)size;

@end
