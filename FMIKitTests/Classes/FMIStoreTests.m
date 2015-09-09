//
//  Created by Florian Mielke on 21.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMIStore.h"

@interface FMIStoreTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIStore *subject;

@end

@implementation FMIStoreTests

- (void)setUp {
    [super setUp];
    self.subject = [[FMIStore alloc] init];
    self.subject.databaseName = @"Event.sqlite";
    self.subject.modelName = @"Event";
    id subjectStub = OCMPartialMock(self.subject);
    OCMStub([subjectStub bundle]).andReturn([NSBundle bundleForClass:[self class]]);
}

- (void)testStoreShouldBeConfigured {
    XCTAssertEqualObjects(self.subject.databaseName, @"Event.sqlite");
    XCTAssertEqualObjects(self.subject.modelName, @"Event");
    XCTAssertNotNil(self.subject.managedObjectContext);
}

- (void)testSharedStoreShouldAlwaysReturnTheSameObject {
    XCTAssertEqualObjects([FMIStore sharedStore], [FMIStore sharedStore]);
}

- (void)testStoreShouldConfigurePersistentStore {
    NSURL *storeURL = [[self.subject applicationDocumentsDirectory] URLByAppendingPathComponent:self.subject.databaseName];

    NSPersistentStore *store = [[self.subject.persistentStoreCoordinator persistentStores] firstObject];

    XCTAssertEqual(store.type, NSSQLiteStoreType);
    XCTAssertTrue([store.options isEqualToDictionary:@{NSSQLitePragmasOption : @{@"journal_mode" : @"DELETE"}}]);
    XCTAssertEqualObjects(store.URL, storeURL);
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:storeURL.path]);
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
    NSURL *storeURL = [self.subject.applicationDocumentsDirectory URLByAppendingPathComponent:self.subject.databaseName];
    (void) self.subject.managedObjectContext;
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:storeURL.path]);

    [self.subject resetPersistentStore];

    XCTAssertFalse([[NSFileManager defaultManager] fileExistsAtPath:storeURL.path]);
}

- (void)testStoreShouldDeleteAllManagedObjects {
    NSManagedObject *event = [NSEntityDescription insertNewObjectForEntityForName:@"FMEvent" inManagedObjectContext:self.subject.managedObjectContext];
    NSManagedObject *attendee1 = [NSEntityDescription insertNewObjectForEntityForName:@"FMAttendee" inManagedObjectContext:self.subject.managedObjectContext];
    NSManagedObject *attendee2 = [NSEntityDescription insertNewObjectForEntityForName:@"FMAttendee" inManagedObjectContext:self.subject.managedObjectContext];
    [attendee1 setValue:event forKey:@"event"];
    [attendee2 setValue:event forKey:@"event"];
    NSFetchRequest *fetchAllEvents = [NSFetchRequest fetchRequestWithEntityName:@"FMEvent"];
    NSArray *allEvents = [self.subject.managedObjectContext executeFetchRequest:fetchAllEvents error:NULL];
    XCTAssertEqual(allEvents.count, (NSUInteger) 1);

    NSFetchRequest *fetchAllAttendees = [NSFetchRequest fetchRequestWithEntityName:@"FMAttendee"];
    NSArray *allAttendees = [self.subject.managedObjectContext executeFetchRequest:fetchAllAttendees error:NULL];
    XCTAssertEqual(allAttendees.count, (NSUInteger) 2);

    [self.subject deleteAllManagedObjects];

    NSArray *eventsAfterDeletion = [self.subject.managedObjectContext executeFetchRequest:fetchAllEvents error:NULL];
    XCTAssertEqual(eventsAfterDeletion.count, (NSUInteger) 0);

    NSArray *attendeesAfterDeletion = [self.subject.managedObjectContext executeFetchRequest:fetchAllAttendees error:NULL];
    XCTAssertEqual(attendeesAfterDeletion.count, (NSUInteger) 0);
}

- (void)testItCreatesANewManagedObjectContext {
    NSManagedObjectContext *managedObjectContext = [self.subject createNewManagedObjectContext];

    XCTAssertEqual(self.subject.persistentStoreCoordinator, managedObjectContext.persistentStoreCoordinator);
    XCTAssertNotEqual(self.subject.managedObjectContext, managedObjectContext);
}

@end
