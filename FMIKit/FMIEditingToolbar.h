//
//  FMIEditingToolbar.h
//
//  Created by Florian Mielke on 03.11.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import UIKit;


/**
 * An editing toolbar is a toolbar that handles to lists of items depending on an editing state.
 */
@interface FMIEditingToolbar : UIToolbar

/**
 * The view controller the toolbar is assigned to.
 */
@property (nonatomic, weak) IBOutlet UIViewController *viewController;

/**
 * The editing button of the assigned view controller.
 */
@property (nonatomic, weak) UIBarButtonItem *editButtonItem;

/**
 * The items displayed on the toolbar when not being in editing mode.
 */
@property (nonatomic, strong) NSArray *defaultItems;

/**
 * The items displayed on the toolbar when being in editing mode.
 */
@property (nonatomic, strong) NSArray *editingItems;

/**
 * A Boolean value indicating whether the toolbar is currently in editing mode.
 */
@property (nonatomic, getter = isEditing) BOOL editing;

/**
 * Sets whether the toolbar shows the editable item.
 * @param editing  If YES, the toolbar should display the editable items; otherwise, NO.
 * @param animated If YES, animates the transition; otherwise, does not.
 */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

/**
 * Prepares the toolbar's items. Subclasses should overwrite this method to prepare it's defaultsItems and editingItems.
 */
- (void)prepareItems;

@end
