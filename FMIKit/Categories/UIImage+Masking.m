//
//  UIImage+Masking.m
//
//  Created by Florian Mielke on 07.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "UIImage+Masking.h"

@implementation UIImage (Masking)


- (UIImage *)imageMaskedWithImage:(UIImage *)maskImage
{
    CGImageRef mask = [self newImageMaskFromImage:maskImage];
    CGImageRef maskedImageRef = CGImageCreateWithMask([self CGImage], mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedImageRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    
    CGImageRelease(mask);  
    CGImageRelease(maskedImageRef);  
    
    return maskedImage;  
}


- (CGImageRef)newImageMaskFromImage:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    return mask;
}


@end
