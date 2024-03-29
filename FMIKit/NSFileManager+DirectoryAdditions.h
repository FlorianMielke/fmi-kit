//
//  NSFileManager+DirectoryAdditions.h
//
//  Created by Florian Mielke on 20.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Adds directory methods to NSFileManager.
 */
@interface NSFileManager (DirectoryAdditions)

/**
 * Returns the URL to the app documents directory.
 * @return The URL to the app documents directory.
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSURL *fm_applicationDocumentsDirectory;

/**
 * Returns the URL to the app inbox directory.
 * @return The URL to the app inbox directory.
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSURL *fm_applicationInboxDirectory;

/**
 * Removes all items from the application inbox directory.
 */
- (void)fm_removeApplicationInboxDirectory;

/**
 * Removes all items from a given directory
 * @param directoryPath The directory path
 * @return BOOL A flag that determines whether the operation was successful. Returns NO if directoryPath is nil or not a directory.
 */
- (BOOL)fm_removeItemsFromDirectoryAtPath:(NSString *)directoryPath;

/**
 * Removes all cloud store items
 * @param error If an error occurs, upon return contains an NSError object that describes the problem. Pass NULL if you don’t want error information.
 * @return BOOL A flag that determines whether the operation was successful. Otherwise returns NO.
 */
- (BOOL)fmi_removeCloudDirectoryWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
