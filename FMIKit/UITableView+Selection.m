//
//  UITableView+Selection.m
//
//  Created by Florian Mielke on 29.07.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "UITableView+Selection.h"


@implementation UITableView (Selection)


- (void)deselectSelectedRowAnimated:(BOOL)animated
{
	NSIndexPath *indexPath = [self indexPathForSelectedRow];
	
	if (indexPath) {
		[self deselectRowAtIndexPath:indexPath animated:animated];
	}
}

@end
