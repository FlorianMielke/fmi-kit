//
//  UIColor+SystemDefaults.h
//
//  Created by Florian Mielke on 09.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *	Adds factory methods to UIColor to provide system default colors.
 */
@interface UIColor (SystemDefaults)

/**
 *	Returns the system color used for the detail label of a cell with default style.
 *	@return	The UIColor object.
 */
+ (instancetype)cellDefaultStyleDetailLabelColor;

@end
