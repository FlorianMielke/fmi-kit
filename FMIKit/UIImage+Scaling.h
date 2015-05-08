//
//  UIImage+Scaling.h
//  MediaService
//
//  Created by Florian Mielke on 10.01.13.
//  Copyright (c) 2013 Deutsche Messe Interactive GmbH. All rights reserved.
//

@import UIKit;

@interface UIImage (Scaling)

+ (UIImage *)imageWithImage:(UIImage *)sourceImage scaledToWidth:(CGFloat)width;

@end
