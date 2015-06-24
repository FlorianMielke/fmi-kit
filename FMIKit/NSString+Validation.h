//
//  NSString+Validation.h
//
//  Created by Florian Mielke on 25.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;


/**
 * This category add methods to NSString to improve general validation operations.
 */
@interface NSString (Validation)

/**
 * Checks whether the receiver is numeric or not
 * @return BOOL YES if receiver contains only numeric characters, NO if not
 */
@property (readonly, getter=isNumeric, NS_NONATOMIC_IOSONLY) BOOL numeric;

@end
