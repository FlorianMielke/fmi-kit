//
//  FMIDatePickerController.h
//
//  Created by Florian Mielke on 14.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;
@import UIKit;


@class FMIDatePickerController;


/**
 *	The delegate of a FMIDatePickerController object must adopt the FMIDatePickerControllerDelegate protocol.
 */
@protocol FMIDatePickerControllerDelegate <NSObject>

/**
 *	Informs the delegate that the date picker's date was changed.
 *	@param	controller	The controller informing the delegate of this event.
 *	@param	date	The new date of the date picker.
 */
- (void)datePickerController:(FMIDatePickerController *)controller didChangeDate:(NSDate *)date;


@optional

/**
 *	Ask the delegate return a list of compound controller to balance toggle call with.
 *	@param	controller	The controller requesting this information.
 *	@return	A list of controller to balance the toggle call with.
 */
- (NSArray *)compoundControllerForDatePickerController:(FMIDatePickerController *)controller;

/**
 *	Informs the delegate that the date picker is about to be shown.
 *	@param	controller	The controller informing the delegate of this event.
 */
- (void)datePickerControllerWillShowDatePicker:(FMIDatePickerController *)controller;

/**
 *	Informs the delegate that the date picker is about to be hidden.
 *	@param	controller	The controller informing the delegate of this event.
 */
- (void)datePickerControllerWillHideDatePicker:(FMIDatePickerController *)controller;

/**
 *	Informs the delegate that the date picker is shown.
 *	@param	controller	The controller informing the delegate of this event.
 */
- (void)datePickerControllerDidShowDatePicker:(FMIDatePickerController *)controller;

/**
 *	Informs the delegate that the date picker is hidden.
 *	@param	controller	The controller informing the delegate of this event.
 */
- (void)datePickerControllerDidHideDatePicker:(FMIDatePickerController *)controller;

@end



/**
 *	An instance of FMIDatePickerController handles the appearancs of an inline UIDatePicker within an UITableView.
 */
@interface FMIDatePickerController : NSObject

/**
 *	The date picker.
 */
@property (nonatomic, strong, readonly) UIDatePicker *datePicker;

/**
 *	The receiver’s delegate.
 *  @see FMIDatePickerControllerDelegate.
 */
@property (nonatomic, weak) id <FMIDatePickerControllerDelegate> delegate;

/**
 *	The index path of the UIDatePicker row.
 */
@property (nonatomic, strong, readonly) NSIndexPath *indexPath;

/**
 *	A Boolean that indicates whether the date picker is shown or not.
 */
@property (nonatomic, assign, readonly) BOOL showsDatePicker;

/**
 *	The table view the date picker row is located in.
 */
@property (nonatomic, weak, readonly) UITableView *tableView;

/**
 *	Creates and returns a new FMIDatePickerController instance.
 *	@param	tableView	The table view of the UIDatePicker row.
 *	@param	indexPath	The index path of the UIDatePicker row.
 *	@return	A new FMIDatePickerController instance. Nil if indexPath it nil.
 */
- (instancetype)initWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;

/**
 *	Returns a Boolean that indicates whether the date picker row is at a given index path.
 *	@param	indexPath	An index path.
 *	@return	YES if the date picker row ist at the given index path, otherwise NO.
 */
- (BOOL)isDatePickerRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *	The date picker mode.
 *	@param	datePickerMode	A date picker mode.
 */
- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode;

/**
 *	The initial date picker date.
 *	@param	date	A date.
 */
- (void)setDate:(NSDate *)date;

/**
 *	The date picker time zone.
 *	@param	timeZone	A time zone.
 */
- (void)setTimeZone:(NSTimeZone *)timeZone;

/**
 *	Returns the estimated height for the date picker row.
 *	@return	A floating-point value that specifies the height (in points) that row should be.
 */
- (CGFloat)estimatedHeightForDatePickerRow;

/**
 * Loads the date picker if needed and insert it into the table view row at the given index path.
 */
- (void)toggleDatePicker;

@end
