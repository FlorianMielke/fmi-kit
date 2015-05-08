//
//  FMFoundationAdditions.h
//
//  Created by Florian Mielke on 30.03.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;
#import <objc/runtime.h>


@class NSString;

/**
 * A foundation addition to return the name of an ivar of an object.
 * @param ivar An ivar to get the name of.
 * @param object The object to search for the ivar.
 * @return NSString The namen of the ivar. Nil if ivar was not found.
 */
NSString *NSStringFromIvarInObj(id ivar, id obj);