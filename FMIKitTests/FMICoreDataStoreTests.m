//
//  Created by Florian Mielke on 21.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMICoreDataStore.h"
#import "FMICoreDataStoreConfiguration.h"

@interface FMICoreDataStoreTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMICoreDataStore *subject;
@property (NS_NONATOMIC_IOSONLY) NSURL *storeURL;
@property (NS_NONATOMIC_IOSONLY) FMICoreDataStoreConfiguration *configuration;

@end

@implementation FMICoreDataStoreTests

- (void)setUp {
    [super setUp];
    NSString *storePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Event.sqlite"];
    self.storeURL = [NSURL fileURLWithPath:storePath];
    NSString *modelPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"Event" ofType:@"momd"];
    NSURL *managedObjectModelURL = [NSURL fileURLWithPath:modelPath];
    self.subject = [[FMICoreDataStore alloc] init];
    self.configuration = [[FMICoreDataStoreConfiguration alloc] initWithManagedObjectModelURL:managedObjectModelURL fetchCloudStatus:nil localStoreURL:self.storeURL localStoreOptions:nil cloudStoreURL:nil cloudStoreOptions:nil];
    [self.subject useSQLiteStoreWithConfiguration:self.configuration];
}

- (void)testSharedStoreShouldAlwaysReturnTheSameObject {
    XCTAssertEqualObjects([FMICoreDataStore sharedStore], [FMICoreDataStore sharedStore]);
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
