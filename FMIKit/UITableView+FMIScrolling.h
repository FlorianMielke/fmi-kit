//
// Created by Florian Mielke on 23.07.18.
// Copyright (c) 2018 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	Adds methods to UITableView for handling scrolling;
 */
@interface UITableView (FMIScrolling)

- (void)fmi_scrollToNearestRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

@end