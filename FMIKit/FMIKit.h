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
#import <FMIKit/FMIComparator.h>
#import <FMIKit/FMIDateHelper.h>
#import <FMIKit/FMIGMTDateHelper.h>
#import <FMIKit/FMITimeZoneHelper.h>
#import <FMIKit/FMIUUIDHelper.h>

#import <FMIKit/FMIYear.h>
#import <FMIKit/FMIPeriod.h>
#import <FMIKit/FMIDuration.h>
#import <FMIKit/FMIDurationFormatter.h>

#pragma mark - Common

#import <FMIKit/NSBundle+FMIAppInfo.h>

#if !TARGET_OS_WATCH

#import <FMIKit/UIDevice+Platform.h>
#import <FMIKit/UITableView+IndexPath.h>

#import <FMIKit/FMIAlertController.h>
#import <FMIKit/FMITableView.h>

#pragma mark - Messages

#import <FMIKit/FMIAttachment.h>
#import <FMIKit/FMIErrorMessage.h>

#pragma mark - Common

#import <FMIKit/FMIURLProvider.h>

#endif
