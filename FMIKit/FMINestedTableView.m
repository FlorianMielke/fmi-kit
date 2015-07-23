//
//  Created by Florian Mielke on 04.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMINestedTableView.h"

@interface FMINestedTableView ()

@property (strong, NS_NONATOMIC_IOSONLY) NSMutableArray *indexPathsForNestedRows;
@property (strong, NS_NONATOMIC_IOSONLY) NSIndexPath *indexPathForRootRow;
@property (assign, NS_NONATOMIC_IOSONLY) UIEdgeInsets rootRowSeparatorInsets;

@end

@implementation FMINestedTableView

@dynamic delegate;
@dynamic dataSource;

#pragma mark - Table view lifecycle

- (NSInteger)numberOfVisibleNestedRowsInSection:(NSInteger)section {
    if (!self.allowsNestedRows) {
        return 0;
    }

    if (![self showsNestedRows]) {
        return 0;
    }

    if (![self isRootRowSectionEqualToSection:section]) {
        return 0;
    }

    return [self numberOfNestedRowsForRowAtIndexPath:self.indexPathForRootRow];
}

- (UITableViewCell *)configuredCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.allowsNestedRows) {
        return nil;
    }

    if ([self isNestedRowAtIndexPath:indexPath]) {
        NSInteger index = [self indexForNestedRowAtIndexPath:indexPath];
        return [self.dataSource nestedTableView:self cellForNestedRowAtIndex:index rootRowIndexPath:self.indexPathForRootRow];
    }

    indexPath = [self adjustedIndexPathForIndexPath:indexPath];
    return [self.dataSource nestedTableView:self cellForRowAtIndexPath:indexPath];
}

- (BOOL)editableRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.allowsNestedRows) {
        return [self.dataSource nestedTableView:self canEditRowAtIndexPath:indexPath];
    }

    if ([self isNestedRowAtIndexPath:indexPath]) {
        NSInteger index = [self indexForNestedRowAtIndexPath:indexPath];
        return [self.dataSource nestedTableView:self canEditNestedRowAtIndex:index rootRowIndexPath:self.indexPathForRootRow];
    }

    indexPath = [self adjustedIndexPathForIndexPath:indexPath];
    return [self.dataSource nestedTableView:self canEditRowAtIndexPath:indexPath];
}

- (void)passSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.allowsNestedRows) {
        [self.delegate nestedTableView:self didSelectRowAtIndexPath:indexPath];
    }

    if ([self isNestedRowAtIndexPath:indexPath]) {
        NSInteger index = [self indexForNestedRowAtIndexPath:indexPath];
        [self.delegate nestedTableView:self didSelectNestedRowAtIndex:index rootRowIndexPath:self.indexPathForRootRow];
    } else {
        indexPath = [self adjustedIndexPathForIndexPath:indexPath];

        if ([self hasNestedRowsForRowAtIndexPath:indexPath]) {
            [self toggleNestedRowsForRowAtIndexPath:indexPath];
        } else {
            [self hideNestedRows];
            [self.delegate nestedTableView:self didSelectRowAtIndexPath:indexPath];
        }
    }
}

- (void)passCommitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.allowsNestedRows) {
        [self.dataSource nestedTableView:self commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }

    if ([self isNestedRowAtIndexPath:indexPath]) {
        NSInteger index = [self indexForNestedRowAtIndexPath:indexPath];
        [self.dataSource nestedTableView:self commitEditingStyle:editingStyle forNestedRowAtIndexPath:indexPath nestedItemIndex:index rootRowIndexPath:self.indexPathForRootRow];
    } else {
        indexPath = [self adjustedIndexPathForIndexPath:indexPath];
        [self.dataSource nestedTableView:self commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (BOOL)isNestedRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.indexPathsForNestedRows containsObject:indexPath];
}

- (void)hideNestedRows {
    [self hideNestedRowsForRowAtIndexPath:self.indexPathForRootRow];
}

#pragma mark - Operations

- (void)toggleNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.allowsNestedRows) {
        return;
    }

    [self deselectRowAtIndexPath:indexPath animated:YES];

    [self beginUpdates];

    if ([self isRootRowAtIndexPath:indexPath]) {
        [self hideNestedRowsForRowAtIndexPath:indexPath];
    } else {
        [self hideNestedRowsForRowAtIndexPath:self.indexPathForRootRow];

        if ([self hasNestedRowsForRowAtIndexPath:indexPath]) {
            [self showNestedRowsForRowAtIndexPath:indexPath];
        }
    }

    [self endUpdates];
}

- (void)showNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexPathForRootRow = indexPath;
    [self prepareNestedIndexPathsForIndexPath:self.indexPathForRootRow];
    [self insertRowsAtIndexPaths:self.indexPathsForNestedRows withRowAnimation:UITableViewRowAnimationTop];

    self.rootRowSeparatorInsets = [self cellForRootRow].separatorInset;
    [self cellForRootRow].separatorInset = UIEdgeInsetsZero;

    [self scrollToRowAtIndexPath:self.indexPathForRootRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)hideNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self cellForRootRow].separatorInset = self.rootRowSeparatorInsets;

    self.indexPathForRootRow = nil;
    [self deleteRowsAtIndexPaths:self.indexPathsForNestedRows withRowAnimation:UITableViewRowAnimationTop];
    [self.indexPathsForNestedRows removeAllObjects];
}

#pragma mark - Utilities

- (void)prepareNestedIndexPathsForIndexPath:(NSIndexPath *)indexPath {
    NSInteger numberOfNestedRows = [self numberOfNestedRowsForRowAtIndexPath:indexPath];
    NSInteger firstRow = indexPath.row + 1;

    for (NSInteger row = firstRow; row < firstRow + numberOfNestedRows; row++) {
        [self.indexPathsForNestedRows addObject:[NSIndexPath indexPathForRow:row inSection:indexPath.section]];
    }
}

- (NSIndexPath *)adjustedIndexPathForIndexPath:(NSIndexPath *)indexPath {
    if (!self.allowsNestedRows) {
        return indexPath;
    }

    if (![self showsNestedRows]) {
        return indexPath;
    }

    if (![self isRootRowSectionEqualToSection:indexPath.section]) {
        return indexPath;
    }

    if ([self isRootRowIndexPathAfterIndexPath:indexPath]) {
        return indexPath;
    }

    if ([self isRootRowAtIndexPath:indexPath]) {
        return indexPath;
    }

    if ([self isNestedRowAtIndexPath:indexPath]) {
        return indexPath;
    }

    NSInteger row = indexPath.row - [self numberOfVisibleNestedRowsInSection:indexPath.section];
    return [NSIndexPath indexPathForRow:row inSection:indexPath.section];
}

- (NSInteger)indexForNestedRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self isNestedRowAtIndexPath:indexPath]) {
        return NSNotFound;
    }

    return indexPath.row - self.indexPathForRootRow.row - 1;
}

- (BOOL)showsNestedRows {
    return (self.indexPathForRootRow != nil);
}

- (NSInteger)numberOfNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource nestedTableView:self numberOfNestedRowsForRowAtIndexPath:indexPath];
}

- (BOOL)hasNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource nestedTableView:self hasNestedRowsForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)cellForRootRow {
    return ([self showsNestedRows]) ? [self cellForRowAtIndexPath:self.indexPathForRootRow] : nil;
}

- (BOOL)isRootRowSectionEqualToSection:(NSInteger)section {
    return (section == self.indexPathForRootRow.section);
}

- (BOOL)isRootRowAtIndexPath:(NSIndexPath *)indexPath {
    return ([indexPath compare:self.indexPathForRootRow] == NSOrderedSame);
}

- (BOOL)isRootRowIndexPathAfterIndexPath:(NSIndexPath *)indexPath {
    return ([self.indexPathForRootRow compare:indexPath] == NSOrderedDescending);
}

#pragma mark - Global setting

- (void)setAllowsNestedRows:(BOOL)allowsNestedRows {
    if (_allowsNestedRows != allowsNestedRows) {
        _allowsNestedRows = allowsNestedRows;

        if (_allowsNestedRows) {
            self.indexPathsForNestedRows = [[NSMutableArray alloc] init];
        } else {
            [self.indexPathsForNestedRows removeAllObjects];
            self.indexPathForRootRow = nil;
        }
    }
}

@end
