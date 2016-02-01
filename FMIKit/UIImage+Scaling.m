//
//  UIImage+Scaling.m
//  MediaService
//
//  Created by Florian Mielke on 10.01.13.
//  Copyright (c) 2013 Deutsche Messe Interactive GmbH. All rights reserved.
//

#import "UIImage+Scaling.h"

@implementation UIImage (Scaling)

+ (UIImage *)imageWithImage:(UIImage *)sourceImage scaledToWidth:(CGFloat)width {
    CGFloat oldWidth = [sourceImage size].width;
    CGFloat scaleFactor = width / oldWidth;
    CGFloat newHeight = [sourceImage size].height * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    [sourceImage drawInRect:CGRectMake(0.0, 0.0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
