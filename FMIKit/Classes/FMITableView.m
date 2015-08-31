//
//  FMITableView.m
//
//  Created by Florian Mielke on 21.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMITableView.h"
#import "UITableView+IndexPath.h"

@interface FMITableView ()

@property(NS_NONATOMIC_IOSONLY) BOOL allRowsAreSelected;

@end

@implementation FMITableView

@dynamic delegate;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (!editing) {
        self.allRowsAreSelected = NO;
    }
}

- (void)selectAllRows {
    if (!self.isValidDateForAllRowsSelection) {
        return;
    }
    [self fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        if ([self.delegate tableView:self willSelectRowAtIndexPath:indexPath]) {
            [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.delegate tableView:self didSelectRowAtIndexPath:indexPath];
        }
    }];
    self.allRowsAreSelected = YES;
    [self.delegate tableViewDidSelectAllRows:self];
}

- (void)deselectAllRows {
    if (!self.isValidDateForAllRowsSelection) {
        return;
    }
    [self fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
        if ([self.delegate tableView:self willSelectRowAtIndexPath:indexPath] != nil) {
            [self deselectRowAtIndexPath:indexPath animated:NO];
            [self.delegate tableView:self didDeselectRowAtIndexPath:indexPath];
        }
    }];
    self.allRowsAreSelected = NO;
    [self.delegate tableViewDidDeselectAllRows:self];
}

- (BOOL)hasSelectedAllRows {
    return self.allRowsAreSelected;
}

- (BOOL)isValidDateForAllRowsSelection {
    return (self.editing && self.allowsAllRowsSelectionDuringEditing);
}

- (void)setAllowsAllRowsSelectionDuringEditing:(BOOL)allowsAllRowsSelectionDuringEditing {
    _allowsAllRowsSelectionDuringEditing = allowsAllRowsSelectionDuringEditing;
    self.allowsMultipleSelectionDuringEditing = _allowsAllRowsSelectionDuringEditing;
}

@end
