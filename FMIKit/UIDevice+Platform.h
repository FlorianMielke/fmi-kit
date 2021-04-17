//
//  UIDevice+Platform.h
//
//  Created by Florian Mielke on 09.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * This category adds methods to UIDevice to determine more information about the current device.
 */
@interface UIDevice (Platform)

/**
 * The device platform identifier.
 * @note Possible examples are @"iPhone1,1" and @"iPod2,1".
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *platformIdentifier;

/**
 * The name of the device's platform.
 * @note Possible examples are @”iPhone 4” and @”iPad 2 (WiFi)”.
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *platform;

@property (readonly, getter=isIOS8, NS_NONATOMIC_IOSONLY) BOOL IOS8;
@property (readonly, getter=isIPad, NS_NONATOMIC_IOSONLY) BOOL isIPad;

@end
