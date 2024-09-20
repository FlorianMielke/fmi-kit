//
//  Created by Florian Mielke on 12.11.12.
//  Copyright (c) 2012 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCalendar (SharedInstances)

+ (NSCalendar *)sharedCurrentCalendar;

+ (NSCalendar *)sharedGMTCalendar;

@end

NS_ASSUME_NONNULL_END
