//
//  Created by Florian Mielke on 12.11.12.
//  Copyright (c) 2012 Florian Mielke. All rights reserved.
//

#import "NSCalendar+SharedInstances.h"

@implementation NSCalendar (SharedInstances)

+ (NSCalendar *)sharedCurrentCalendar {
    static NSCalendar *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [NSCalendar currentCalendar];
    });
    return sharedInstance;
}

+ (NSCalendar *)sharedGMTCalendar {
    static NSCalendar *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [NSCalendar currentCalendar];
        [sharedInstance setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    });
    return sharedInstance;
}

@end
