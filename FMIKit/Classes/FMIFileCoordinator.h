#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIFileCoordinator : NSObject

- (void)unarchiveObjectAtURL:(NSURL *)url withCompletionHandler:(void (^)(id unarchivedObject, NSError *error))completionHandler;

- (void)archiveObject:(id <NSSecureCoding>)anObject atURL:(NSURL *)url withCompletionHandler:(void (^)(BOOL success, NSError *error))completionHandler;

- (void)removeFileAtURL:(NSURL *)url withCompletionHandler:(void (^)(NSError *error))completionHandler;

- (void)copyFromURL:(NSURL *)fromURL toURL:(NSURL *)toURL;

- (void)findFilesOfDirectoryAtURL:(NSURL *)url matchingPredicate:(nullable NSPredicate *)predicate withCompletionHandler:(void (^)(NSArray<NSURL *> *urls, NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END