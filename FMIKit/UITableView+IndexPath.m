//
//  UITableView+IndexPath.m
//
//  Created by Florian Mielke on 28/4/11.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

#import "UITableView+IndexPath.h"

@implementation UITableView (IndexPath)

- (BOOL)fm_isEmpty {
  __block BOOL empty = YES;
  [self fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
    if (indexPath != nil) {
      empty = NO;
      *stop = YES;
    }
  }];
  return empty;
}

- (nullable NSIndexPath *)fm_firstIndexPath {
  if (self.fm_isEmpty) {
    return nil;
  }
  return [NSIndexPath indexPathForRow:0 inSection:0];
}

- (nullable NSIndexPath *)fm_lastIndexPath {
  if (self.fm_isEmpty) {
    return nil;
  }
  NSInteger lastSection = self.numberOfSections - 1;
  NSInteger lastRow = [self numberOfRowsInSection:lastSection] - 1;
  return [NSIndexPath indexPathForRow:lastRow inSection:lastSection];
}

- (BOOL)fmi_hasIndexPath:(NSIndexPath *)indexPath {
  return ([self cellForRowAtIndexPath:indexPath] != nil);
}

- (nullable NSIndexPath *)fm_lastIndexPathInSection:(NSInteger)section {
  if (self.fm_isEmpty) {
    return nil;
  }
  NSInteger lastRow = [self numberOfRowsInSection:section] - 1;
  return [NSIndexPath indexPathForRow:lastRow inSection:section];
}

- (nullable NSIndexPath *)fm_indexPathForRowAfterIndexPath:(NSIndexPath *)indexPath {
  if (self.fm_isEmpty || indexPath == nil || ![self fmi_hasIndexPath:indexPath]) {
    return nil;
  }
  NSInteger nextRow = indexPath.row + 1;
  NSInteger lastRowInSection = [self numberOfRowsInSection:indexPath.section] - 1;
  BOOL hasNextRowInSection = nextRow <= lastRowInSection;
  if (hasNextRowInSection) {
    return [NSIndexPath indexPathForRow:nextRow inSection:indexPath.section];
  }
  NSInteger nextSection = indexPath.section + 1;
  BOOL hasNextSection = (nextSection <= self.numberOfSections - 1);
  if (hasNextSection) {
    return [NSIndexPath indexPathForRow:0 inSection:nextSection];
  }
  return nil;
}

- (nullable NSIndexPath *)fm_indexPathForRowBeforeIndexPath:(NSIndexPath *)indexPath {
  if (self.fm_isEmpty || indexPath == nil || ![self fmi_hasIndexPath:indexPath]) {
    return nil;
  }
  BOOL isFirstIndexPathInTable = (indexPath.row == 0 && indexPath.section == 0);
  if (isFirstIndexPathInTable) {
    return nil;
  }
  BOOL isFirstIndexPathInSection = (indexPath.row == 0 && indexPath.section > 0);
  if (isFirstIndexPathInSection) {
    NSInteger previousSection = indexPath.section - 1;
    NSInteger lastRowInPreviousSection = [self numberOfRowsInSection:previousSection] - 1;
    return [NSIndexPath indexPathForRow:lastRowInPreviousSection inSection:previousSection];
  }
  NSInteger previousRow = indexPath.row - 1;
  return [NSIndexPath indexPathForRow:previousRow inSection:indexPath.section];
}

- (nullable NSString *)fm_reuseIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.fm_isEmpty || indexPath == nil || [indexPath compare:self.fm_lastIndexPath] == NSOrderedDescending) {
    return nil;
  }
  return [[self cellForRowAtIndexPath:indexPath] reuseIdentifier];
}

- (BOOL)fm_isRowWithReuseIdentifier:(NSString *)reuseIdentifier atIndexPath:(NSIndexPath *)indexPath {
  return ([[self fm_reuseIdentifierForRowAtIndexPath:indexPath] isEqualToString:reuseIdentifier]);
}

#pragma mark - Enumeration

- (void)fm_enumerateIndexPathsUsingBlock:(void (^)(NSIndexPath *indexPath, BOOL *stop))block {
  BOOL stop = NO;
  for (NSInteger section = 0; section < self.numberOfSections; section++) {
    for (NSInteger row = 0; row < [self numberOfRowsInSection:section]; row++) {
      NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
      if (block) {
        block(indexPath, &stop);
      }
      if (stop) {
        break;
      }
    }
    if (stop) {
      break;
    }
  }
}

@end
