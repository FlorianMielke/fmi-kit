#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSPersistentStoreCoordinator (Migration)

@property (nullable, readonly, NS_NONATOMIC_IOSONLY) NSPersistentStore *fmi_currentPersistentStore;

- (nullable NSPersistentStore *)fmi_migrateCurrentStoreToURL:(NSURL *)URL options:(nullable NSDictionary *)options withType:(NSString *)storeType error:(NSError **)error;

- (BOOL)fmi_removeCurrentStoreWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END