#import "FMIFileCoordinator.h"

@implementation FMIFileCoordinator

- (void)unarchiveObjectAtURL:(NSURL *)url withCompletionHandler:(void (^)(id unarchivedObject, NSError *error))completionHandler {
    NSError *readError;
    id unarchivedObject;
    NSData *contents = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&readError];
    if (contents) {
        unarchivedObject = [NSKeyedUnarchiver unarchiveObjectWithData:contents];
        NSAssert(unarchivedObject != nil, @"The provided URL must correspond to an unarchivable object.");
    }
    if (completionHandler) {
        completionHandler(unarchivedObject, readError);
    }
}

- (void)archiveObject:(id <NSSecureCoding>)anObject atURL:(NSURL *)url withCompletionHandler:(void (^)(BOOL success, NSError *error))completionHandler {
    NSError *error;
    NSData *archivedObjectData = [NSKeyedArchiver archivedDataWithRootObject:anObject];
    BOOL success = [archivedObjectData writeToURL:url options:NSDataWritingAtomic error:&error];
    if (success) {
        NSDictionary *fileAttributes = @{NSFileExtensionHidden: @YES};
        [[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:url.path error:nil];
    }
    if (completionHandler) {
        completionHandler(success, error);
    }
}

- (void)removeFileAtURL:(NSURL *)url withCompletionHandler:(void (^)(BOOL success, NSError *error))completionHandler {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL removed = [fileManager removeItemAtURL:url error:&error];
    if (completionHandler) {
        completionHandler(removed, error);
    }
}

- (void)copyFromURL:(NSURL *)fromURL toURL:(NSURL *)toURL withCompletionHandler:(void (^)(BOOL success, NSError *error))completionHandler {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL copied = [fileManager copyItemAtURL:fromURL toURL:toURL error:&error];
    if (!copied) {
        NSLog(@"Failed to move file %@ to: %@. Error: %@", fromURL.absoluteString, toURL.absoluteString, error.localizedDescription);
        if (completionHandler) {
            completionHandler(NO, error);
        }
    } else {
        if (completionHandler) {
            completionHandler(YES, error);
        }
    }
}

- (void)findFilesOfDirectoryAtURL:(NSURL *)url matchingPredicate:(nullable NSPredicate *)predicate withCompletionHandler:(void (^)(NSArray<NSURL *> *urls, NSError *error))completionHandler {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *allURLs = [fileManager contentsOfDirectoryAtURL:url includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsPackageDescendants error:nil];
    NSArray *matchedURLs = (predicate) ? [allURLs filteredArrayUsingPredicate:predicate] : allURLs;
    if (completionHandler) {
        completionHandler(matchedURLs, nil);
    }
}

@end
