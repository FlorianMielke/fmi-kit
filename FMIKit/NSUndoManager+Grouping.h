//
//  NSUndoManager+Grouping.h
//
//  Created by Florian Mielke on 27.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * This category add grouping methods to NSUndoManger.
 */
@interface NSUndoManager (Grouping)

/**
 * Ends the last open undo group if there's one.
 */
- (void)savelyEndUndoGrouping;

/**
 * Begins a new undo group if neither is open.
 */
- (void)savelyBeginUndoGrouping;

@end
