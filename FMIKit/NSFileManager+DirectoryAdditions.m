//
//  NSFileManager+DirectoryAdditions.m
//
//  Created by Florian Mielke on 20.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSFileManager+DirectoryAdditions.h"
#import "FMIKitConstants.h"

@implementation NSFileManager (DirectoryAdditions)

- (NSURL *)fm_applicationDocumentsDirectory {
    return [[self URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)fm_applicationInboxDirectory {
    return [[self fm_applicationDocumentsDirectory] URLByAppendingPathComponent:@"Inbox" isDirectory:YES];
}

- (void)fm_removeApplicationInboxDirectory {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] initWithFilePresenter:nil];
        NSURL *inboxURL = [self fm_applicationInboxDirectory];
        BOOL isDir;
        if ([self fileExistsAtPath:[inboxURL path] isDirectory:&isDir] && isDir) {
            NSError *coordinatorError = nil;
            [coordinator coordinateWritingItemAtURL:(NSURL *) inboxURL options:NSFileCoordinatorWritingForDeleting error:&coordinatorError byAccessor:^(NSURL *newURL) {
                NSError *managerError = nil;
                [self removeItemAtURL:newURL error:&managerError];
            }];
        }
    });
}

- (BOOL)fm_removeItemsFromDirectoryAtPath:(NSString *)directoryPath {
    BOOL isDirectory = NO;
    if (!directoryPath || ![self fileExistsAtPath:directoryPath isDirectory:&isDirectory] || !isDirectory) {
        return NO;
    }
    NSError *error = nil;
    NSURL *directoryURL = [[NSURL alloc] initFileURLWithPath:directoryPath];
    NSArray *urlsOfItemsInDirectory = [self contentsOfDirectoryAtURL:directoryURL includingPropertiesForKeys:nil options:0 error:&error];
    if (!error) {
        for (NSURL *itemUrl in urlsOfItemsInDirectory) {
            [self removeItemAtURL:itemUrl error:&error];
        }
    }
    return (!error);
}

- (BOOL)fmi_removeCloudDirectoryWithError:(NSError **)error {
    NSError *removingCloudDirectoryError;
    NSURL *cloudDirectoryURL = [self.fm_applicationDocumentsDirectory URLByAppendingPathComponent:@"CoreDataUbiquitySupport" isDirectory:YES];
    BOOL removedCloudDirectory = [self removeItemAtURL:cloudDirectoryURL error:&removingCloudDirectoryError];
    if (!removedCloudDirectory) {
        *error = removingCloudDirectoryError;
    }
    return removedCloudDirectory;
}

@end
