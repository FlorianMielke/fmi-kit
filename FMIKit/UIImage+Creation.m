//
//  UIImage+Creation.m
//
//  Created by Florian Mielke on 11.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "UIImage+Creation.h"

@implementation UIImage (Creation)


+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
