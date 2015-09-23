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

- (void)archiveObject:(id <NSSecureCoding>)anObject atURL:(NSURL *)url withCompletionHandler:(void (^)(NSError *))completionHandler {
    NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
    NSFileAccessIntent *writingIntent = [NSFileAccessIntent writingIntentWithURL:url options:NSFileCoordinatorWritingForMerging];
    [fileCoordinator coordinateAccessWithIntents:@[writingIntent] queue:self.queue byAccessor:^(NSError *accessError) {
        if (accessError) {
            if (completionHandler) {
                completionHandler(accessError);
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
            completionHandler(error);
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

- (void)findFilesOfDirectoryAtURL:(NSURL *)url matchingPredicate:(NSPredicate *)predicate withCompletionHandler:(void (^)(NSArray *files, NSError *error))completionHandler {
    dispatch_queue_t defaultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(defaultQueue, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *files = [fileManager contentsOfDirectoryAtURL:url includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsPackageDescendants error:nil];
        NSArray *matchedFiles = [files filteredArrayUsingPredicate:predicate];
        if (completionHandler) {
            completionHandler(matchedFiles, nil);
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
