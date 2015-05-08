//
//  NSFileManagerDirectoryAdditionsTests.m
//
//  Created by Florian Mielke on 20.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSFileManager+DirectoryAdditions.h"


@interface NSFileManager_DirectoryAdditionsTests : XCTestCase

@property (nonatomic, strong) NSFileManager *sut;
@property (nonatomic, strong) NSURL *applicationDocumentsDirectory;

@end



@implementation NSFileManager_DirectoryAdditionsTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];
    
    self.applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    self.sut = [[NSFileManager alloc] init];
}


- (void)tearDown
{
    self.sut = nil;
    self.applicationDocumentsDirectory = nil;
    
    [super tearDown];
}



#pragma mark - Tests

- (void)testRemovingItemsReturnsNoForNilURL
{
    XCTAssertFalse([self.sut fm_removeItemsFromDirectoryAtPath:nil]);
}


- (void)testRemovingItemsReturnsNoForNonDirectoryURL
{
    NSString *nonDirectoryPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"file.txt"];
    XCTAssertFalse([self.sut fm_removeItemsFromDirectoryAtPath:nonDirectoryPath]);
}


- (void)testRemovingItemsRemovesAllItemsInDirectory
{
    // Given
    NSError *error = nil;
    NSString *testDirectoryPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"/test/"];
    [self.sut createDirectoryAtPath:testDirectoryPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *testFileContentOne = @"Lorem ipsum 1";
    NSData *testFileDataOne = [testFileContentOne dataUsingEncoding:NSUTF8StringEncoding];
    NSString *testFilePathOne = [testDirectoryPath stringByAppendingPathComponent:testFileContentOne];
    [testFileDataOne writeToFile:testFilePathOne atomically:YES];

    NSString *testFileContentTwo = @"Lorem ipsum 2";
    NSData *testFileDataTwo = [testFileContentOne dataUsingEncoding:NSUTF8StringEncoding];
    NSString *testFilePathTwo = [testDirectoryPath stringByAppendingPathComponent:testFileContentTwo];
    [testFileDataTwo writeToFile:testFilePathTwo atomically:YES];
    
    // When
    [self.sut fm_removeItemsFromDirectoryAtPath:testDirectoryPath];
    
    // Then
    NSArray *contentsOfDirectory = [self.sut contentsOfDirectoryAtPath:testDirectoryPath error:nil];
    XCTAssertEqual([contentsOfDirectory count], (NSUInteger)0);
}


- (void)testManagerShouldReturnApplicationDocumentsDirectory
{
    XCTAssertEqualObjects([self.sut fm_applicationDocumentsDirectory], self.applicationDocumentsDirectory);
}


- (void)testManagerShouldReturnApplicationInboxDirectory
{
    // Given
    NSURL *inboxDir = [self.applicationDocumentsDirectory URLByAppendingPathComponent:@"Inbox" isDirectory:YES];
    
    // Then
    XCTAssertEqualObjects([self.sut fm_applicationInboxDirectory], inboxDir);
}


@end
