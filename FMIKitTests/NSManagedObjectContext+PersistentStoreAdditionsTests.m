//
//  NSManagedObjectContextPersistentStoreAdditionsTests.m
//
//  Created by Florian Mielke on 24.03.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSManagedObjectContext+PersistentStoreAdditions.h"


@interface NSManagedObjectContext_PersistentStoreAdditionsTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) NSManagedObjectContext *sut;

@end



@implementation NSManagedObjectContext_PersistentStoreAdditionsTests

#pragma mark - Fixture

- (void)setUp
{
    [super setUp];
    
    NSArray *bundles = @[[NSBundle bundleForClass:[self class]]];
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
    XCTAssertTrue([self.sut persistentStoreIsEmtpyForEntities:@[@"Unkown"]]);
}


- (void)testCheckForEmtpyStoreReturnsFalseForOneEntity
{

    [NSEntityDescription insertNewObjectForEntityForName:@"FMEvent" inManagedObjectContext:self.sut];
    
    XCTAssertFalse([self.sut persistentStoreIsEmtpyForEntities:@[@"FMEvent"]]);
}


- (void)testCheckForEmtpyStoreReturnsFalseForTwoEntitiesWithOnlyOneEmtpy
{

    [NSEntityDescription insertNewObjectForEntityForName:@"FMEvent" inManagedObjectContext:self.sut];
    NSArray *entitiesToCheck = @[@"FMEvent", @"FMAttendee"];
    
    XCTAssertFalse([self.sut persistentStoreIsEmtpyForEntities:entitiesToCheck]);
}


@end
