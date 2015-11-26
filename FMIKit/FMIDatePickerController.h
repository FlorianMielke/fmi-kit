//
//  FMIDatePickerController.h
//
//  Created by Florian Mielke on 14.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
@property (readonly, NS_NONATOMIC_IOSONLY) UIDatePicker *datePicker;

/**
 *	The receiver’s delegate.
 *  @see FMIDatePickerControllerDelegate.
 */
@property (weak, NS_NONATOMIC_IOSONLY) id <FMIDatePickerControllerDelegate> delegate;

/**
 *	The index path of the UIDatePicker row.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSIndexPath *indexPath;

/**
 *	A Boolean that indicates whether the date picker is shown or not.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) BOOL showsDatePicker;

/**
 *	The table view the date picker row is located in.
 */
@property (weak, readonly, NS_NONATOMIC_IOSONLY) UITableView *tableView;

/**
 *	A floating-point value that specifies the height (in points) that row should be.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) CGFloat estimatedHeightForDatePickerRow;

/**
 *	Unavailable. Please use initWithTableView:forIndexPath:.
 */
- (instancetype)init NS_UNAVAILABLE;

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
 * Loads the date picker if needed and insert it into the table view row at the given index path.
 */
- (void)toggleDatePicker;

@end
