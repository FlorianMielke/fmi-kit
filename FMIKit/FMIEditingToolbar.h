//
//  FMIEditingToolbar.h
//
//  Created by Florian Mielke on 03.11.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * An editing toolbar is a toolbar that handles to lists of items depending on an editing state.
 */
@interface FMIEditingToolbar : UIToolbar

/**
 * The view controller the toolbar is assigned to.
 */
@property (weak, NS_NONATOMIC_IOSONLY) IBOutlet UIViewController *viewController;

/**
 * The editing button of the assigned view controller.
 */
@property (weak, NS_NONATOMIC_IOSONLY) UIBarButtonItem *editButtonItem;

/**
 * The items displayed on the toolbar when not being in editing mode.
 */
@property (NS_NONATOMIC_IOSONLY) NSArray *defaultItems;

/**
 * The items displayed on the toolbar when being in editing mode.
 */
@property (NS_NONATOMIC_IOSONLY) NSArray *editingItems;

/**
 * A Boolean value indicating whether the toolbar is currently in editing mode.
 */
@property (getter = isEditing, NS_NONATOMIC_IOSONLY) BOOL editing;

/**
 * Sets whether the toolbar shows the editable item.
 * @param editing  If YES, the toolbar should display the editable items; otherwise, NO.
 * @param animated If YES, animates the transition; otherwise, does not.
 */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

/**
 * Prepares the toolbar's items. Subclasses should overwrite this method to reset it's defaultsItems and editingItems.
 */
- (void)prepareItems;

@end
