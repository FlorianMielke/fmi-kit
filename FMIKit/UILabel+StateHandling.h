//
//  UILabel+StateHandling.h
//
//  Created by Florian Mielke on 18.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Adds methods to UILabel to handle active and valid states.
 */
@interface UILabel (StateHandling)

/**
 * If YES, changes the textColor to tintColor, otherwise to default detial label color.
 * @param active YES if active, otherwise NO.
 */
- (void)fm_markAsActive:(BOOL)active;

/**
 * If YES, cancels the text, otherwise reverts canceled text.
 * @param valid YES to cancel, otherwise NO.
 */
- (void)fm_markAsValid:(BOOL)valid;

/**
 * Updates the attributedText property with the given text without changing the current attributes.
 * @param text The label's text.
 */
- (void)fm_setAttributedText:(NSString *)text;

@end
