//
//  Created by Florian Mielke on 07.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double FMIKitVersionNumber;
FOUNDATION_EXPORT const unsigned char FMIKitVersionString[];

#import <FMIKit/FMIHelpers.h>
#import <FMIKit/NSArray+FMIValidation.h>
#import <FMIKit/NSArray+Querying.h>
#import <FMIKit/NSCalendar+Calculations.h>
#import <FMIKit/NSCalendar+SharedInstances.h>
#import <FMIKit/NSCoder+SecureCoding.h>
#import <FMIKit/NSData+FileAdditions.h>
#import <FMIKit/NSDateFormatter+Timing.h>
#import <FMIKit/NSFileManager+DirectoryAdditions.h>
#import <FMIKit/NSNumberFormatter+Editing.h>
#import <FMIKit/NSString+CSV.h>
#import <FMIKit/NSString+FileName.h>
#import <FMIKit/NSString+FMIDrawing.h>
#import <FMIKit/NSString+Folding.h>
#import <FMIKit/UIColor+SystemDefaults.h>

#import <FMIKit/FMIBinding.h>
#import <FMIKit/FMIBindingManager.h>
#import <FMIKit/FMIComparator.h>
#import <FMIKit/FMIDateHelper.h>
#import <FMIKit/FMIGMTDateHelper.h>
#import <FMIKit/FMIStore.h>
#import <FMIKit/FMITimeZoneHelper.h>
#import <FMIKit/FMIUUIDHelper.h>

#import <FMIKit/FMIYear.h>
#import <FMIKit/FMIMonth.h>
#import <FMIKit/FMIWeek.h>
#import <FMIKit/FMIPeriod.h>
#import <FMIKit/FMIDuration.h>
#import <FMIKit/FMIDurationFormatter.h>

#pragma mark - Common

#import <FMIKit/NSBundle+FMIAppInfo.h>

#pragma mark - Persistence

#import <FMIKit/FMICSVDeserializer.h>
#import <FMIKit/FMICSVFieldDeserializer.h>
#import <FMIKit/FMICSVFileDescription.h>
#import <FMIKit/FMIFieldDescription.h>
#import <FMIKit/FMIFileCoordinator.h>

#if !TARGET_OS_WATCH

#import <FMIKit/FMIKitFactory.h>

#import <FMIKit/NSUndoManager+Grouping.h>
#import <FMIKit/UIDevice+Platform.h>
#import <FMIKit/UIImage+Resizing.h>
#import <FMIKit/UILabel+StateHandling.h>
#import <FMIKit/UITableView+IndexPath.h>
#import <FMIKit/UITableView+Selection.h>
#import <FMIKit/UITableView+FMIScrolling.h>
#import <FMIKit/UIScrollView+Scrolling.h>
#import <FMIKit/UIView+I7ShakeAnimation.h>
#import <FMIKit/NSIndexPath+Comparing.h>

#import <FMIKit/FMIAlertController.h>
#import <FMIKit/FMIAlertView.h>
#import <FMIKit/FMIEventParser.h>
#import <FMIKit/FMITableView.h>

#pragma mark - Messages

#import <FMIKit/FMIMessageMIMETypes.h>
#import <FMIKit/FMIMessageAttachment.h>
#import <FMIKit/FMISupportMessage.h>
#import <FMIKit/FMIAttachment.h>
#import <FMIKit/FMIErrorMessage.h>

#pragma mark - Common

#import <FMIKit/FMIURLProvider.h>

#pragma mark - Review & What's New

#import <FMIKit/FMIReviewNotificationCoordinator.h>
#import <FMIKit/FMIReviewNotificationViewController.h>

#endif
