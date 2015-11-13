//
//  Created by Florian Mielke on 07.05.15.
//  Copyright (c) 2015 madeFM. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double FMIKitVersionNumber;
FOUNDATION_EXPORT const unsigned char FMIKitVersionString[];

#import <FMIKit/FMIHelpers.h>
#import <FMIKit/NSArray+Initialization.h>
#import <FMIKit/NSArray+Querying.h>
#import <FMIKit/NSBundle+Configuration.h>
#import <FMIKit/NSCalendar+Calculations.h>
#import <FMIKit/NSCalendar+SharedInstances.h>
#import <FMIKit/NSCoder+SecureCoding.h>
#import <FMIKit/NSData+FileAdditions.h>
#import <FMIKit/NSDateFormatter+Timing.h>
#import <FMIKit/NSDecimalNumber+Calulations.h>
#import <FMIKit/NSFileManager+DirectoryAdditions.h>
#import <FMIKit/NSIndexSet+Initialization.h>
#import <FMIKit/NSMutableDictionary+IndexPath.h>
#import <FMIKit/NSNumberFormatter+Editing.h>
#import <FMIKit/NSObject+AutoDescription.h>
#import <FMIKit/NSString+CSV.h>
#import <FMIKit/NSString+Validation.h>
#import <FMIKit/NSString+FileName.h>
#import <FMIKit/NSString+FMIDrawing.h>
#import <FMIKit/NSString+Folding.h>
#import <FMIKit/UIColor+SystemDefaults.h>

#import <FMIKit/FMIBinding.h>
#import <FMIKit/FMIBindingManager.h>
#import <FMIKit/FMIComparator.h>
#import <FMIKit/FMICSVDeserializer.h>
#import <FMIKit/FMICSVFieldDeserializer.h>
#import <FMIKit/FMICSVFileDescription.h>
#import <FMIKit/FMIDuration.h>
#import <FMIKit/FMIDurationFormatter.h>
#import <FMIKit/FMIFieldDescription.h>
#import <FMIKit/FMIFoundationAdditions.h>
#import <FMIKit/FMIDateHelper.h>
#import <FMIKit/FMIGMTDateHelper.h>
#import <FMIKit/FMITimeZoneHelper.h>
#import <FMIKit/FMIUUIDHelper.h>
#import <FMIKit/FMIFileCoordinator.h>

#if !TARGET_OS_WATCH

#import <FMIKit/NSUndoManager+Grouping.h>
#import <FMIKit/SKProduct+LocalizedPrice.h>
#import <FMIKit/UIDevice+Platform.h>
#import <FMIKit/UIImage+Creation.h>
#import <FMIKit/UIImage+Masking.h>
#import <FMIKit/UIImage+Resizing.h>
#import <FMIKit/UIImage+Scaling.h>
#import <FMIKit/UILabel+Animating.h>
#import <FMIKit/UILabel+Sizing.h>
#import <FMIKit/UILabel+StateHandling.h>
#import <FMIKit/UITableView+IndexPath.h>
#import <FMIKit/UITableView+Selection.h>
#import <FMIKit/UIScrollView+Scrolling.h>
#import <FMIKit/UIView+I7ShakeAnimation.h>
#import <FMIKit/NSIndexPath+Comparing.h>
#import <FMIKit/NSManagedObjectContext+PersistentStoreAdditions.h>
#import <FMIKit/NSPersistentStoreCoordinator+Validation.h>

#import <FMIKit/FMIActionSheet.h>
#import <FMIKit/FMIAlertController.h>
#import <FMIKit/FMIAlertView.h>
#import <FMIKit/FMIKitFactory.h>
#import <FMIKit/FMIAcceptedCell.h>
#import <FMIKit/FMIDatePickerController.h>
#import <FMIKit/FMIEditingToolbar.h>
#import <FMIKit/FMIEventParser.h>
#import <FMIKit/FMIMessageMIMETypes.h>
#import <FMIKit/FMIMessageAttachment.h>
#import <FMIKit/FMINestedTableView.h>
#import <FMIKit/FMINonAminatedPushSegue.h>
#import <FMIKit/FMINumericTextView.h>
#import <FMIKit/FMIStore.h>
#import <FMIKit/FMISupportMessage.h>
#import <FMIKit/FMITableView.h>

#endif