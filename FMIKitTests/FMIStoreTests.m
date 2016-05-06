//
//  Created by Florian Mielke on 21.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMIStore.h"

@interface FMIStoreTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIStore *subject;
@property (NS_NONATOMIC_IOSONLY) NSURL *storeURL;

@end

@implementation FMIStoreTests

- (void)setUp {
    [super setUp];
    NSString *storePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Event.sqlite"];
    self.storeURL = [NSURL fileURLWithPath:storePath];
    self.subject = [[FMIStore alloc] init];
    self.subject.localStoreURL = self.storeURL;
    NSString *modelPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Event" ofType:@"momd"];
    self.subject.managedObjectModelURL = [NSURL fileURLWithPath:modelPath];
}

- (void)testSharedStoreShouldAlwaysReturnTheSameObject {
    XCTAssertEqualObjects([FMIStore sharedStore], [FMIStore sharedStore]);
}

- (void)testStoreShouldConfigurePersistentStore {
    NSPersistentStore *store = self.subject.persistentStoreCoordinator.persistentStores.firstObject;

    XCTAssertEqual(store.type, NSSQLiteStoreType);
    XCTAssertTrue([store.options isEqualToDictionary:@{NSSQLitePragmasOption : @{@"journal_mode" : @"DELETE"}}]);
    XCTAssertEqualObjects(store.URL, self.storeURL);
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:self.storeURL.path]);
}

- (void)testStoreShouldConfigureInMemoryStore {
    [self.subject useInMemoryStore];

    NSPersistentStore *store = self.subject.persistentStoreCoordinator.persistentStores.firstObject;
    XCTAssertEqual(store.type, NSInMemoryStoreType);
}

- (void)testStoreShouldResetTheCoreDataStack {
    NSManagedObjectContext *managedObjectContext = self.subject.managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = self.subject.persistentStoreCoordinator;

    [self.subject resetCoreDataStack];

    XCTAssertNotEqualObjects(managedObjectContext, self.subject.managedObjectContext);
    XCTAssertNotEqualObjects(persistentStoreCoordinator, self.subject.persistentStoreCoordinator);
}

- (void)testStoreShouldReturnTrueForEmptyPersistentStore {
    self.subject.baseEntityNames = @[@"FMEvent"];
    XCTAssertTrue(self.subject.isPersistentStoreEmpty);
}

- (void)testStoreShouldReturnFalseForMissingBaseEntityNamesWhenCheckingForEmptyPersistentStore {
    XCTAssertFalse(self.subject.isPersistentStoreEmpty);
}

- (void)testStoreShouldReturnFalseForNotEmptyPersistentStore {
    self.subject.baseEntityNames = @[@"FMEvent"];
    [NSEntityDescription insertNewObjectForEntityForName:@"FMEvent" inManagedObjectContext:self.subject.managedObjectContext];
    XCTAssertFalse(self.subject.isPersistentStoreEmpty);
}

- (void)testStoreShouldRemovePersistentStoreFile {
    (void) self.subject.managedObjectContext;
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:self.storeURL.path]);

    [self.subject resetPersistentStore];

    XCTAssertFalse([[NSFileManager defaultManager] fileExistsAtPath:self.storeURL.path]);
}

- (void)testItCreatesANewManagedObjectContext {
    NSManagedObjectContext *managedObjectContext = [self.subject createNewManagedObjectContext];

    XCTAssertEqual(self.subject.persistentStoreCoordinator, managedObjectContext.persistentStoreCoordinator);
    XCTAssertNotEqual(self.subject.managedObjectContext, managedObjectContext);
}

@end
