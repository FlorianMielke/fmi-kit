#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIFileCoordinator : NSObject

- (void)unarchiveObjectAtURL:(NSURL *)url withCompletionHandler:(void (^)(id unarchivedObject, NSError *error))completionHandler;

- (void)archiveObject:(id <NSSecureCoding>)anObject atURL:(NSURL *)url withCompletionHandler:(void (^)(NSError *))completionHandler;

- (void)removeFileAtURL:(NSURL *)url withCompletionHandler:(void (^)(NSError *error))completionHandler;

- (void)findFilesOfDirectoryAtURL:(NSURL *)url matchingPredicate:(NSPredicate *)predicate withCompletionHandler:(void (^)(NSArray *files, NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END