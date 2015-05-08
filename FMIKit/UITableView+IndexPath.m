//
//  UITableView+IndexPath.m
//
//  Created by Florian Mielke on 28/4/11.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

#import "UITableView+IndexPath.h"


@implementation UITableView (IndexPath)


- (BOOL)fm_isEmpty
{
    __block BOOL empty = YES;
    
    [self fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
       
        if (indexPath != nil) {
            empty = NO;
            *stop = YES;
        }
        
    }];
    
    return empty;
}


- (NSIndexPath *)fm_firstIndexPath
{
    if ([self fm_isEmpty]) {
        return nil;
    }
    
    return [NSIndexPath indexPathForRow:0 inSection:0];
}


- (NSIndexPath *)fm_lastIndexPath
{
    if ([self fm_isEmpty]) {
        return nil;
    }

	NSInteger lastSection = [self numberOfSections] - 1;
	NSInteger lastRow = [self numberOfRowsInSection:lastSection] - 1;
	
	return [NSIndexPath indexPathForRow:lastRow inSection:lastSection];
}


- (NSIndexPath *)fm_lastIndexPathInSection:(NSInteger)section
{
    if ([self fm_isEmpty]) {
        return nil;
    }

	NSInteger lastRow = [self numberOfRowsInSection:section] - 1;
	return [NSIndexPath indexPathForRow:lastRow inSection:section];
}


- (NSIndexPath *)fm_indexPathForRowAfterIndexPath:(NSIndexPath *)indexPath
{
    if ([self fm_isEmpty] || indexPath == nil) {
        return nil;
    }

	NSInteger section = [indexPath section];
	NSInteger row = [indexPath row] + 1;
	
	NSInteger lastRow = [self numberOfRowsInSection:section] - 1;
	
	if (row > lastRow) {
		return nil;
	}
	
	return [NSIndexPath indexPathForRow:row inSection:section];
}


- (NSIndexPath *)fm_indexPathForRowBeforeIndexPath:(NSIndexPath *)indexPath
{
	if ([self fm_isEmpty] || indexPath == nil) {
		return nil;
	}
	
	NSInteger section = [indexPath section];
	NSInteger row = [indexPath row] - 1;
	
	return [NSIndexPath indexPathForRow:row inSection:section];
}


- (NSString *)fm_reuseIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([self fm_isEmpty] || indexPath == nil || [indexPath compare:[self fm_lastIndexPath]] == NSOrderedDescending) {
        return nil;
    }
    
    return [[self cellForRowAtIndexPath:indexPath] reuseIdentifier];
}


- (BOOL)fm_isRowWithReuseIdentifier:(NSString *)reuseIdentifier atIndexPath:(NSIndexPath *)indexPath
{
    return ([[self fm_reuseIdentifierForRowAtIndexPath:indexPath] isEqualToString:reuseIdentifier]);
}



#pragma mark - Enumeration

- (void)fm_enumerateIndexPathsUsingBlock:(void (^)(NSIndexPath *indexPath, BOOL *stop))block
{
    BOOL stop = NO;
    
    for (NSInteger section = 0; section < [self numberOfSections]; section++)
    {
        for (NSInteger row = 0; row < [self numberOfRowsInSection:section]; row++)
        {
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
