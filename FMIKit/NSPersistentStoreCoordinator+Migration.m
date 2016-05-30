#import "NSPersistentStoreCoordinator+Migration.h"

@implementation NSPersistentStoreCoordinator (Migration)

- (nullable NSPersistentStore *)fmi_currentPersistentStore {
    return self.persistentStores.firstObject;
}

- (nullable NSPersistentStore *)fmi_migrateCurrentStoreToURL:(NSURL *)URL options:(nullable NSDictionary *)options withType:(NSString *)storeType error:(NSError **)error {
    return [self migratePersistentStore:self.fmi_currentPersistentStore toURL:URL options:options withType:storeType error:error];
}

- (BOOL)fmi_removeCurrentStoreWithError:(NSError **)error {
    return [self removePersistentStore:self.fmi_currentPersistentStore error:error];
}

@end
