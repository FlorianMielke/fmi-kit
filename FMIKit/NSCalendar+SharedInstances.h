//
//  NSCalendar+SharedInstances.h
//
//  Created by Florian Mielke on 12.11.12.
//  Copyright (c) 2012 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSCalendar (SharedInstances)

+ (id)sharedCurrentCalendar;

+ (id)sharedGMTCalendar;

@end
