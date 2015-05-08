//
//  NSMutableDictionary+IndexPath.m
//
//  Created by Florian Mielke on 20/6/11.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

#import "NSMutableDictionary+IndexPath.h"


@implementation NSMutableDictionary (IndexPath)


- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
	return [self objectForKey:indexPath];
}


- (id)removeObjectAtIndexPath:(NSIndexPath *)indexPath
{
	return [self removeObjectAtIndexPath:indexPath];
}


- (NSArray *)objectsForSection:(NSInteger)section
{
	NSArray *keys = [[self allKeys] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"section = %i", section]];
	return [self objectsForKeys:keys notFoundMarker:[NSNull null]];
}


- (NSArray *)sections
{
	return [[self allKeys] valueForKeyPath:@"@distinctUnionOfObjects.section"];
}


@end
