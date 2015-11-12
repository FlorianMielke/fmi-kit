//
//  FMITableView.h
//
//  Created by Florian Mielke on 21.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMITableView;

@protocol FMITableViewDelegate <NSObject, UITableViewDelegate>

/**
 * Tells the delegate that the all rows are now selected.
 * @param tableView A table-view object informing the delegate about the row selection.
 */
- (void)tableViewDidSelectAllRows:(FMITableView *)tableView;

/**
 * Tells the delegate that the all rows are now deselected.
 * @param tableView A table-view object informing the delegate about the row deselection.
 */
- (void)tableViewDidDeselectAllRows:(FMITableView *)tableView;

@end

@interface FMITableView : UITableView

/**
 * A Boolean value that controls whether users can select all rows simultaneously in editing mode.
 * @note Enabling this property will also enable allowsMultipleSelectionDuringEditing.
 */
@property(NS_NONATOMIC_IOSONLY) BOOL allowsAllRowsSelectionDuringEditing;

/**
 * The object that acts as the delegate of the receiving table view.
 */
@property(weak, NS_NONATOMIC_IOSONLY) id <FMITableViewDelegate> delegate;

/**
 * Returns a Boolean that indicates whether all rows are selected.
 * @return YES if all rows are selected, otherwise NO.
 */
@property(readonly, NS_NONATOMIC_IOSONLY) BOOL hasSelectedAllRows;

/**
 * Selects all rows of the receiver.
 * @note Calling this method cause the delegate to receive a tableViewDidSelectAllRows: message.
 */
- (void)selectAllRows;

/**
 * Deselects all rows of the receiver.
 * @note Calling this method cause the delegate to receive a tableViewDidDeselectAllRows: message.
 */
- (void)deselectAllRows;

@end