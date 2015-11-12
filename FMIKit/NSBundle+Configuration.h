//
//  NSBundle+Configuration.h
//
//  Created by Florian Mielke on 17.01.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Configuration)

@property (readonly, getter=isBeta, NS_NONATOMIC_IOSONLY) BOOL beta;
@property (readonly, getter=isDebug, NS_NONATOMIC_IOSONLY) BOOL debug;

@end