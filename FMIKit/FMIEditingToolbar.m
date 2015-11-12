//
//  FMIEditingToolbar.m
//
//  Created by Florian Mielke on 03.11.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIEditingToolbar.h"


@implementation FMIEditingToolbar


- (void)awakeFromNib
{
    [super awakeFromNib];

    [self prepareItems];
}


- (void)prepareItems
{
    self.editButtonItem = self.viewController.editButtonItem;
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (editing) {
        [self setItems:self.editingItems animated:animated];
    } else {
        [self setItems:self.defaultItems animated:animated];
    }

    self.editing = editing;
}


@end
