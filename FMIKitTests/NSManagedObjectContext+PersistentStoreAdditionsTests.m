//
//  NSManagedObjectContextPersistentStoreAdditionsTests.m
//
//  Created by Florian Mielke on 24.03.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSManagedObjectContext+PersistentStoreAdditions.h"


@interface NSManagedObjectContext_PersistentStoreAdditionsTests : XCTestCase

@property (nonatomic, strong) NSManagedObjectContext *sut;

@end



@implementation NSManagedObjectContext_PersistentStoreAdditionsTests

#pragma mark - Fixture

- (void)setUp
{
    [super setUp];
    
    NSArray *bundles = [NSArray arrayWithObject:[NSBundle bundleForClass:[self class]]];
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:bundles];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    NSDictionary *storeOptions = @{NSSQLitePragmasOption: @{@"journal_mode": @"DELETE"} };
    [persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:0 URL:nil options:storeOptions error:NULL];
    
    self.sut = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.sut setPersistentStoreCoordinator:persistentStoreCoordinator];
}


- (void)tearDown
{
    self.sut = nil;
    
    [super tearDown];
}



#pragma mark - Tests

- (void)testCheckForEmtpyStoreReturnsYesForNilListOfEntities
{
    XCTAssertTrue([self.sut persistentStoreIsEmtpyForEntities:nil]);
}


- (void)testCheckForEmtpyStoreReturnsYesForUnkownEntity
{
    XCTAssertTrue([self.sut persistentStoreIsEmtpyForEntities:[NSArray arrayWithObject:@"Unkown"]]);
}


- (void)testCheckForEmtpyStoreReturnsFalseForOneEntity
{
    // Given
    [NSEntityDescription insertNewObjectForEntityForName:@"FMEvent" inManagedObjectContext:self.sut];
    
    // Then
    XCTAssertFalse([self.sut persistentStoreIsEmtpyForEntities:[NSArray arrayWithObject:@"FMEvent"]]);
}


- (void)testCheckForEmtpyStoreReturnsFalseForTwoEntitiesWithOnlyOneEmtpy
{
    // Given
    [NSEntityDescription insertNewObjectForEntityForName:@"FMEvent" inManagedObjectContext:self.sut];
    NSArray *entitiesToCheck = [NSArray arrayWithObjects:@"FMEvent", @"FMAttendee", nil];
    
    // Then
    XCTAssertFalse([self.sut persistentStoreIsEmtpyForEntities:entitiesToCheck]);
}


@end
