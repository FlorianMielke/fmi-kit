//
//  UIDevice+Platform.h
//
//  Created by Florian Mielke on 09.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;
@import UIKit;


/**
 * This category adds methods to UIDevice to determine more information about the current device.
 */
@interface UIDevice (Platform)

/**
 * The device platform identifier.
 * @note Possible examples are @"iPhone1,1" and @"iPod2,1".
 */
- (NSString *)platformIdentifier;

/**
 * The name of the device's platform.
 * @note Possible examples are @”iPhone 4” and @”iPad 2 (WiFi)”.
 */
- (NSString *)platform;

/**
 *  Checks if the system version of the device is iOS8 or higher
 *
 *  @return YES if systen version is iOS8 or higher, otherwise NO.
 */
- (BOOL)isIOS8;

@end
