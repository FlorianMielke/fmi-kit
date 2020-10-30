#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIFileCoordinator : NSObject

- (BOOL)removeFileAtURL:(NSURL *)url error:(NSError **)error;

- (nullable NSURL *)copyFromURL:(NSURL *)fromURL toURL:(NSURL *)toURL error:(NSError **)error;

- (NSArray<NSURL *> *)findFilesOfDirectoryAtURL:(NSURL *)url matchingPredicate:(nullable NSPredicate *)predicate error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
