//
//  NSBundle+Configuration.m
//
//  Created by Florian Mielke on 17.01.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import "NSBundle+Configuration.h"

@implementation NSBundle (Configuration)

- (BOOL)isBeta {
    return [self.bundleIdentifier hasSuffix:@".beta"];
}

- (BOOL)isDebug {
    return [self.bundleIdentifier hasSuffix:@".debug"];
}



@end
