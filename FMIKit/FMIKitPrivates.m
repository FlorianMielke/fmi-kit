//
//  Created by Florian Mielke on 29.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIKitPrivates.h"

@implementation FMIKitPrivates

+ (NSBundle *)resourcesBundle {
    static NSBundle *bundle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        bundle = [NSBundle bundleForClass:[self class]];
    });
    return bundle;
}

@end
