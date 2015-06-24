//
//  NSIndexPath+Comparing.h
//
//  Created by Florian Mielke on 06.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSIndexPath (Comparing)

/**
 * Returns a Boolean value that indicates whether a given object is an NSIndexPath object and exactly equal the receiver.
 * @param anotherIndexPath The index path to compare with the receiver.
 * @return YES if the anotherIndexPath is an NSIndexPath object and is exactly equal to the receiver, otherwise NO.
 */
- (BOOL)fm_isEqualToIndexPath:(NSIndexPath *)anotherIndexPath;

@end
