//
//  Created by Florian Mielke on 21.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMIStore.h"
#import "FMIStoreConfiguration.h"

@interface FMIStoreTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIStore *subject;
@property (NS_NONATOMIC_IOSONLY) NSURL *storeURL;
@property (NS_NONATOMIC_IOSONLY) FMIStoreConfiguration *configuration;

@end

@implementation FMIStoreTests

- (void)setUp {
    [super setUp];
    NSString *storePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Event.sqlite"];
    self.storeURL = [NSURL fileURLWithPath:storePath];
    NSString *modelPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Event" ofType:@"momd"];
    NSURL *managedObjectModelURL = [NSURL fileURLWithPath:modelPath];
    self.subject = [[FMIStore alloc] init];
    self.configuration = [[FMIStoreConfiguration alloc] initWithManagedObjectModelURL:managedObjectModelURL localStoreURL:self.storeURL localStoreOptions:nil cloudStoreURL:nil cloudStoreOptions:nil];
    [self.subject useSQLiteStoreWithConfiguration:self.configuration];
}

- (void)testSharedStoreShouldAlwaysReturnTheSameObject {
    XCTAssertEqualObjects([FMIStore sharedStore], [FMIStore sharedStore]);
}

- (void)testStoreShouldConfigurePersistentStore {
    NSPersistentStore *store = self.subject.persistentStoreCoordinator.persistentStores.firstObject;

    XCTAssertEqual(store.type, NSSQLiteStoreType);
    XCTAssertEqualObjects(store.URL, self.storeURL);
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:self.storeURL.path]);
}

- (void)testStoreShouldConfigureInMemoryStore {
    [self.subject useInMemoryStoreWithConfiguration:self.configuration];

    NSPersistentStore *store = self.subject.persistentStoreCoordinator.persistentStores.firstObject;
    XCTAssertEqual(store.type, NSInMemoryStoreType);
}

- (void)testItCreatesANewManagedObjectContext {
    NSManagedObjectContext *managedObjectContext = [self.subject createNewManagedObjectContext];

    XCTAssertEqual(self.subject.persistentStoreCoordinator, managedObjectContext.persistentStoreCoordinator);
    XCTAssertNotEqual(self.subject.managedObjectContext, managedObjectContext);
}

@end
