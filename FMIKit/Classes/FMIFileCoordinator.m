#import "FMIFileCoordinator.h"

@implementation FMIFileCoordinator

- (void)unarchiveObjectAtURL:(NSURL *)url withCompletionHandler:(void (^)(id unarchivedObject, NSError *error))completionHandler {
    NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
    BOOL successfulSecurityScopedResourceAccess = [url startAccessingSecurityScopedResource];
    NSFileAccessIntent *readingIntent = [NSFileAccessIntent readingIntentWithURL:url options:NSFileCoordinatorReadingWithoutChanges];
    [fileCoordinator coordinateAccessWithIntents:@[readingIntent] queue:self.queue byAccessor:^(NSError *accessError) {
        if (accessError) {
            if (successfulSecurityScopedResourceAccess) {
                [url stopAccessingSecurityScopedResource];
            }
            if (completionHandler) {
                completionHandler(nil, accessError);
            }
            return;
        }
        NSError *readError;
        id unarchivedObject;
        NSData *contents = [NSData dataWithContentsOfURL:readingIntent.URL options:NSDataReadingUncached error:&readError];
        if (contents) {
            unarchivedObject = [NSKeyedUnarchiver unarchiveObjectWithData:contents];
            NSAssert(unarchivedObject != nil, @"The provided URL must correspond to an unarchivable object.");
        }
        if (successfulSecurityScopedResourceAccess) {
            [url stopAccessingSecurityScopedResource];
        }
        if (completionHandler) {
            completionHandler(unarchivedObject, readError);
        }
    }];
}

- (void)archiveObject:(id <NSSecureCoding>)anObject atURL:(NSURL *)url withCompletionHandler:(void (^)(BOOL success, NSError *error))completionHandler {
    NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
    NSFileAccessIntent *writingIntent = [NSFileAccessIntent writingIntentWithURL:url options:NSFileCoordinatorWritingForReplacing];
    [fileCoordinator coordinateAccessWithIntents:@[writingIntent] queue:self.queue byAccessor:^(NSError *accessError) {
        if (accessError) {
            if (completionHandler) {
                completionHandler(NO, accessError);
            }
            return;
        }
        NSError *error;
        NSData *archivedObjectData = [NSKeyedArchiver archivedDataWithRootObject:anObject];
        BOOL success = [archivedObjectData writeToURL:writingIntent.URL options:NSDataWritingAtomic error:&error];
        if (success) {
            NSDictionary *fileAttributes = @{NSFileExtensionHidden : @YES};
            [[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:writingIntent.URL.path error:nil];
        }
        if (completionHandler) {
            completionHandler(success, error);
        }
    }];
}

- (void)removeFileAtURL:(NSURL *)url withCompletionHandler:(void (^)(NSError *error))completionHandler {
    NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
    BOOL successfulSecurityScopedResourceAccess = [url startAccessingSecurityScopedResource];
    NSFileAccessIntent *writingIntent = [NSFileAccessIntent writingIntentWithURL:url options:NSFileCoordinatorWritingForDeleting];
    [fileCoordinator coordinateAccessWithIntents:@[writingIntent] queue:self.queue byAccessor:^(NSError *accessError) {
        if (accessError) {
            if (completionHandler) {
                completionHandler(accessError);
            }
            return;
        }
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSError *error;
        [fileManager removeItemAtURL:writingIntent.URL error:&error];
        if (successfulSecurityScopedResourceAccess) {
            [url stopAccessingSecurityScopedResource];
        }
        if (completionHandler) {
            completionHandler(error);
        }
    }];
}

- (void)copyFromURL:(NSURL *)fromURL toURL:(NSURL *)toURL {
    NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
    __block NSError *error;
    BOOL successfulSecurityScopedResourceAccess = [fromURL startAccessingSecurityScopedResource];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSURL *tempDirectory = [fileManager URLForDirectory:NSItemReplacementDirectory inDomain:NSUserDomainMask appropriateForURL:toURL create:YES error:&error];
    NSURL *tempURL = [tempDirectory URLByAppendingPathComponent:toURL.lastPathComponent];
    BOOL success = [fileManager copyItemAtURL:fromURL toURL:tempURL error:&error];
    if (!success) {
        NSLog(@"Couldn't create temp file from: %@ at: %@ error: %@.", fromURL.absoluteString, tempURL.absoluteString, error.localizedDescription);
        NSLog(@"Error\nCode: %ld\nDomain: %@\nDescription: %@\nReason: %@\nUser Info: %@\n", (long) error.code, error.domain, error.localizedDescription, error.localizedFailureReason, error.userInfo);
        return;
    }
    NSFileAccessIntent *movingIntent = [NSFileAccessIntent writingIntentWithURL:tempURL options:NSFileCoordinatorWritingForMoving];
    NSFileAccessIntent *mergingIntent = [NSFileAccessIntent writingIntentWithURL:toURL options:NSFileCoordinatorWritingForMerging];
    [fileCoordinator coordinateAccessWithIntents:@[movingIntent, mergingIntent] queue:self.queue byAccessor:^(NSError *accessError) {
        if (accessError) {
            NSLog(@"Couldn't move file: %@ to: %@ error: %@.", fromURL.absoluteString, toURL.absoluteString, accessError.localizedDescription);
            return;
        }
        BOOL success = NO;
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        success = [[NSData dataWithContentsOfURL:movingIntent.URL] writeToURL:mergingIntent.URL atomically:YES];
        if (success) {
            NSDictionary *fileAttributes = @{NSFileExtensionHidden : @YES};
            [[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:mergingIntent.URL.path error:&error];
        }
        if (successfulSecurityScopedResourceAccess) {
            [fromURL stopAccessingSecurityScopedResource];
        }
        if (!success) {
            NSLog(@"Couldn't move file: %@ to: %@ error: %@.", fromURL.absoluteString, toURL.absoluteString, error.localizedDescription);
            NSLog(@"Error\nCode: %ld\nDomain: %@\nDescription: %@\nReason: %@\nUser Info: %@\n", (long) error.code, error.domain, error.localizedDescription, error.localizedFailureReason, error.userInfo);
        }
        [fileManager removeItemAtURL:tempDirectory error:&error];
    }];
}

- (void)findFilesOfDirectoryAtURL:(NSURL *)url matchingPredicate:(nullable NSPredicate *)predicate withCompletionHandler:(void (^)(NSArray<NSURL *> *urls, NSError *error))completionHandler {
    dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(defaultQueue, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *allURLs = [fileManager contentsOfDirectoryAtURL:url includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsPackageDescendants error:nil];
        NSArray *matchedURLs = (predicate) ? [allURLs filteredArrayUsingPredicate:predicate] : allURLs;
        if (completionHandler) {
            completionHandler(matchedURLs, nil);
        }
    });
}

- (NSOperationQueue *)queue {
    static NSOperationQueue *queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
    });
    return queue;
}

@end
