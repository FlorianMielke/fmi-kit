//
//  NSString+Folding.h
//
//  Created by Florian Mielke on 27.04.12.
//  Copyright (c) 2012 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This category adds methods to NSString to enhance folding.
 */
@interface NSString (Folding)

/**
 * Returns a NSString based on the receiver folded confirming to the iCalendar format (RFC 5545).
 * @param numberOfOctets The number octect where to fold the receiver.
 * @return Returns a new string that is folded.
 * @note Confirming to the iCalendar format (RFC 5545) a line is not longer than 75 octets. The inserted linebreaks are in CRLF format. Every new line starts with a whitespace.
 */
- (NSString *)stringByFoldingToOctects:(NSInteger)numberOfOctets;

@end
