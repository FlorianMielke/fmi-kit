//
//  UITableView+IndexPath.h
//
//  Created by Florian Mielke on 28/4/11.
//  Copyright 2011 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	Adds methods to UITableView for handling NSIndexPaths;
 */
@interface UITableView (IndexPath)

/**
 * A Boolean that indcates whether the receiver has any sections containing any rows.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) BOOL fm_isEmpty;

/**
 *	The first index path of the receiver.
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSIndexPath *fm_firstIndexPath;

/**
 *	The last index path of the receiver.
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSIndexPath *fm_lastIndexPath;

/**
 *	Returns the last index path in a given section.
 *	@param	section	A section.
 *	@return	The last index path of section.
 */
- (NSIndexPath *)fm_lastIndexPathInSection:(NSInteger)section;

/**
 *	Returns the first index path before a given index path.
 *	@param	indexPath	An index path.
 *	@return	The first index path before indexPath.
 */
- (NSIndexPath *)fm_indexPathForRowBeforeIndexPath:(NSIndexPath *)indexPath;

/**
 *	Returns the first index path after a given index path.
 *	@param	indexPath	An index path.
 *	@return	The first index path after indexPath.
 */
- (NSIndexPath *)fm_indexPathForRowAfterIndexPath:(NSIndexPath *)indexPath;

/**
 *	Returns a Boolean that indicates whether the row at a given index path has the given reuse identifier.
 *	@param	reuseIdentifier	A reuse identifier.
 *	@param	indexPath	An index path.
 *	@return	YES if the row at indexPath has a reuse identifier equal to reuseIdentifier, otherwise NO.
 */
- (BOOL)fm_isRowWithReuseIdentifier:(NSString *)reuseIdentifier atIndexPath:(NSIndexPath *)indexPath;

/**
 *	Returns the reuse identifier for the row at a given index path.
 *	@param	indexPath	An index path.
 *	@return	The reuse identifier of the of at a given index path.
 */
- (NSString *)fm_reuseIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Executes a given block using each index path in the table view, starting with the first index path and continuing through to the last index path.
 * @param block The block to apply to index paths in the table view.
 */
- (void)fm_enumerateIndexPathsUsingBlock:(void (^)(NSIndexPath *indexPath, BOOL *stop))block;

@end
