//
//  NSBundle+Configuration.h
//
//  Created by Florian Mielke on 17.01.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

@import Foundation;

@interface NSBundle (Configuration)

@property (NS_NONATOMIC_IOSONLY, readonly, getter=isBeta) BOOL beta;
@property (NS_NONATOMIC_IOSONLY, readonly, getter=isDebug) BOOL debug;

@end