//
//  Created by Florian Mielke on 21.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import <OCMock/OCMock.h>
#import "FMIStore.h"


@interface FMIStoreTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIStore *sut;

@end



@implementation FMIStoreTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    self.sut = [[FMIStore alloc] init];
    self.sut.databaseName = @"Event.sqlite";
    self.sut.modelName = @"Event";
    
    id mockSut = [OCMockObject partialMockForObject:self.sut];
    [[[mockSut stub] andReturn:[NSBundle bundleForClass:[self class]]] bundle];
}


- (void)tearDown
{
    [self.sut resetPersistentStore];
    self.sut = nil;
    
    [super tearDown];
}



#pragma mark - Tests

- (void)testStoreShouldBeInitialized
{
    XCTAssertNotNil(self.sut);
}


- (void)testStoreShouldBeConfigured
{
    XCTAssertEqualObjects(self.sut.databaseName, @"Event.sqlite");
    XCTAssertEqualObjects(self.sut.modelName, @"Event");
    XCTAssertNotNil(self.sut.managedObjectContext);
}


- (void)testSharedStoreShouldAlwaysReturnTheSameObject
{
    XCTAssertEqualObjects([FMIStore sharedStore], [FMIStore sharedStore]);
}


- (void)testStoreShouldConfigurePersistentStore
{

    NSURL *storeURL = [[self.sut applicationDocumentsDirectory] URLByAppendingPathComponent:self.sut.databaseName];
    
    NSPersistentStore *store = [[self.sut.persistentStoreCoordinator persistentStores] firstObject];
    XCTAssertEqual([store type], NSSQLiteStoreType);
    XCTAssertTrue([[store options] isEqualToDictionary:@{NSSQLitePragmasOption: @{@"journal_mode": @"DELETE"}}]);
    XCTAssertEqualObjects([store URL], storeURL);
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]);
}


- (void)testStoreShouldConfigureInMemoryStore
{
    // When
    [self.sut useInMemoryStore];
    
    NSPersistentStore *store = [[self.sut.persistentStoreCoordinator persistentStores] firstObject];
    XCTAssertEqual([store type], NSInMemoryStoreType);
}


- (void)testStoreShouldResetTheCoreDataStack
{

    NSManagedObjectContext *managedObjectContext = self.sut.managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = self.sut.persistentStoreCoordinator;
    
    [self.sut resetCoreDataStack];
    
    XCTAssertNotEqualObjects(managedObjectContext, self.sut.managedObjectContext);
    XCTAssertNotEqualObjects(persistentStoreCoordinator, self.sut.persistentStoreCoordinator);
}


- (void)testStoreShouldReturnTrueForEmptyPersistentStore
{

    self.sut.baseEntityNames = @[@"FMEvent"];
    
    XCTAssertTrue(self.sut.isPersistentStoreEmpty);
}


- (void)testStoreShouldReturnFalseForMissingBaseEntityNamesWhenCheckingForEmptyPersistentStore
{
    XCTAssertFalse(self.sut.isPersistentStoreEmpty);
}


- (void)testStoreShouldReturnFalseForNotEmptyPersistentStore
{

    self.sut.baseEntityNames = @[@"FMEvent"];
    [NSEntityDescription insertNewObjectForEntityForName:@"FMEvent" inManagedObjectContext:self.sut.managedObjectContext];

    // Then
    XCTAssertFalse(self.sut.isPersistentStoreEmpty);
}


- (void)testStoreShouldRemovePersistentStoreFile
{

    NSURL *storeURL = [[self.sut applicationDocumentsDirectory] URLByAppendingPathComponent:self.sut.databaseName];
    [self.sut managedObjectContext];
    
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]);
    
    [self.sut resetPersistentStore];
    
    XCTAssertFalse([[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]);
}


- (void)testStoreShouldDeleteAllManagedObjects
{

    NSManagedObject *event = [NSEntityDescription insertNewObjectForEntityForName:@"FMEvent" inManagedObjectContext:self.sut.managedObjectContext];
    NSManagedObject *attendee1 = [NSEntityDescription insertNewObjectForEntityForName:@"FMAttendee" inManagedObjectContext:self.sut.managedObjectContext];
    NSManagedObject *attendee2 = [NSEntityDescription insertNewObjectForEntityForName:@"FMAttendee" inManagedObjectContext:self.sut.managedObjectContext];
    [attendee1 setValue:event forKey:@"event"];
    [attendee2 setValue:event forKey:@"event"];

    NSFetchRequest *fetchAllEvents = [NSFetchRequest fetchRequestWithEntityName:@"FMEvent"];
    NSArray *allEvents = [self.sut.managedObjectContext executeFetchRequest:fetchAllEvents error:NULL];
    XCTAssertEqual([allEvents count], (NSUInteger)1);

    NSFetchRequest *fetchAllAttendees = [NSFetchRequest fetchRequestWithEntityName:@"FMAttendee"];
    NSArray *allAttendees = [self.sut.managedObjectContext executeFetchRequest:fetchAllAttendees error:NULL];
    XCTAssertEqual([allAttendees count], (NSUInteger)2);
    
    [self.sut deleteAllManagedObjects];
    
    NSArray *eventsAfterDeletion = [self.sut.managedObjectContext executeFetchRequest:fetchAllEvents error:NULL];
    XCTAssertEqual([eventsAfterDeletion count], (NSUInteger)0);

    NSArray *attendeesAfterDeletion = [self.sut.managedObjectContext executeFetchRequest:fetchAllAttendees error:NULL];
    XCTAssertEqual([attendeesAfterDeletion count], (NSUInteger)0);
}



@end
