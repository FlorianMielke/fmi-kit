//
//  FMITableView.m
//
//  Created by Florian Mielke on 21.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMITableView.h"
#import "UITableView+IndexPath.h"


@interface FMITableView ()

@property (nonatomic) BOOL allRowsAreSelected;

@end



@implementation FMITableView

@dynamic delegate;

#pragma mark - Editing

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (!editing) {
        self.allRowsAreSelected = NO;
    }
}



#pragma mark - Selection

- (void)selectAllRows
{
    if (![self isValidDateForAllRowsSelection]) {
        return;
    }
    
    [self fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        
        if ([[self delegate] tableView:self willSelectRowAtIndexPath:indexPath] != nil)
        {
            [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [[self delegate] tableView:self didSelectRowAtIndexPath:indexPath];
        }
        
    }];
    
    [self setAllRowsAreSelected:YES];
    [[self delegate] tableViewDidSelectAllRows:self];
}


- (void)deselectAllRows
{
    if (![self isValidDateForAllRowsSelection]) {
        return;
    }

    [self fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        
        if ([[self delegate] tableView:self willSelectRowAtIndexPath:indexPath] != nil)
        {
            [self deselectRowAtIndexPath:indexPath animated:NO];
            [[self delegate] tableView:self didDeselectRowAtIndexPath:indexPath];
        }
        
    }];
    
    [self setAllRowsAreSelected:NO];
    [[self delegate] tableViewDidDeselectAllRows:self];
}


- (BOOL)hasSelectedAllRows
{
    return [self allRowsAreSelected];
}


- (BOOL)isValidDateForAllRowsSelection
{
    return ([self isEditing] && [self allowsAllRowsSelectionDuringEditing]);
}


- (void)setAllowsAllRowsSelectionDuringEditing:(BOOL)allowsAllRowsSelectionDuringEditing
{
    _allowsAllRowsSelectionDuringEditing = allowsAllRowsSelectionDuringEditing;
    [self setAllowsMultipleSelectionDuringEditing:_allowsAllRowsSelectionDuringEditing];
}


@end
