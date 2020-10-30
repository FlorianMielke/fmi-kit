#import "FMIFileCoordinator.h"

@interface FMIFileCoordinator () <NSFileManagerDelegate>

@end

@implementation FMIFileCoordinator

- (BOOL)removeFileAtURL:(NSURL *)url error:(NSError **)error {
    return [[NSFileManager defaultManager] removeItemAtURL:url error:error];
}

- (nullable NSURL *)copyFromURL:(NSURL *)fromURL toURL:(NSURL *)toURL error:(NSError **)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:toURL.path]) {
        BOOL removed = [fileManager removeItemAtURL:toURL error:error];
        if (!removed) {
            return nil;
        }
    }
    BOOL copied = [fileManager copyItemAtURL:fromURL toURL:toURL error:error];
    if (copied) {
        return toURL;
    }
    return nil;
}

- (NSArray<NSURL *> *)findFilesOfDirectoryAtURL:(NSURL *)url matchingPredicate:(nullable NSPredicate *)predicate error:(NSError **)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *allURLs = [fileManager contentsOfDirectoryAtURL:url includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsPackageDescendants error:error];
    return (predicate) ? [allURLs filteredArrayUsingPredicate:predicate] : allURLs;
}

@end
