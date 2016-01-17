//
//  UIImage+Resizing.m
//
//  Created by Florian Mielke on 16/6/11.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

#import "UIImage+Resizing.h"


@implementation UIImage (Resizing)


- (UIImage *)scaledImageToFitSize:(CGSize)size
{
    CGSize newSize = [self proportionalSizeForSize:size];

    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (CGSize)proportionalSizeForSize:(CGSize)size
{
    float hfactor = self.size.width / size.width;
    float vfactor = self.size.height / size.height;
    
    float factor = fmax(hfactor, vfactor);
    
    float newWidth = roundf(self.size.width / factor);
    float newHeight = roundf(self.size.height / factor);
    
    return CGSizeMake(newWidth, newHeight);
}


@end
