//
//  NSDecimalNumber+Calulations.h
//
//  Created by Florian Mielke on 14.01.14.
//  Copyright (c) 2014 madeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Adds calculation methods to NSDecimalNumber.
 */
@interface NSDecimalNumber (Calulations)

/**
 * Returns true whether the receiver is negative.
 * @return YES if the receiver is negative, otherwise NO.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) BOOL fm_isNegative;

/**
 * Inverts the receiver.
 * @return The inverted receiver.
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSDecimalNumber *fm_invertedNumber;

/**
 * Calculates the modulo of the receiver by a given divisor.
 * @param divisor The divisor.
 * @return The calculated modulo.
 */
- (NSDecimalNumber *)fm_moduloFor:(NSDecimalNumber *)divisor;

@end
