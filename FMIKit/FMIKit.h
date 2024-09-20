//
//  Created by Florian Mielke on 07.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double FMIKitVersionNumber;
FOUNDATION_EXPORT const unsigned char FMIKitVersionString[];

#import <FMIKit/FMIHelpers.h>
#import <FMIKit/NSCalendar+SharedInstances.h>

#import <FMIKit/FMIBinding.h>
#import <FMIKit/FMIBindingManager.h>
#import <FMIKit/FMIDateHelper.h>
#import <FMIKit/FMIGMTDateHelper.h>

#pragma mark - Common

#import <FMIKit/NSBundle+FMIAppInfo.h>

#if !TARGET_OS_WATCH

#import <FMIKit/UIDevice+Platform.h>
#import <FMIKit/UITableView+IndexPath.h>

#pragma mark - Common

#import <FMIKit/FMIURLProvider.h>

#endif
