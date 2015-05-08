//
//  NSMutableDictionary+NSIndexPath.h
//
//  Created by Florian Mielke on 20/6/11.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

@import Foundation;


@interface NSMutableDictionary (NSIndexPath)

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

- (id)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)objectsForSection:(NSInteger)section;

- (NSArray *)sections;

@end
