#import "FMIFileCoordinator.h"

@implementation FMIFileCoordinator

- (nullable id)unarchiveObjectAtURL:(NSURL *)url error:(NSError **)error {
    id unarchivedObject;
    NSData *contents = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:error];
    if (contents != nil) {
        unarchivedObject = [NSKeyedUnarchiver unarchiveObjectWithData:contents];
    }
    return unarchivedObject;
}

- (BOOL)archiveObject:(id <NSSecureCoding>)anObject atURL:(NSURL *)url error:(NSError **)error {
    NSData *archivedObjectData = [NSKeyedArchiver archivedDataWithRootObject:anObject];
    BOOL success = [archivedObjectData writeToURL:url options:NSDataWritingAtomic error:error];
    if (success) {
        NSDictionary *fileAttributes = @{NSFileExtensionHidden: @YES};
        [[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:url.path error:nil];
    }
    return success;
}

- (BOOL)removeFileAtURL:(NSURL *)url error:(NSError **)error {
    return [[NSFileManager defaultManager] removeItemAtURL:url error:error];
}

- (nullable NSURL *)copyFromURL:(NSURL *)fromURL toURL:(NSURL *)toURL error:(NSError **)error {
    BOOL copied = [[NSFileManager defaultManager] copyItemAtURL:fromURL toURL:toURL error:error];
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
