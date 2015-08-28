//
//  NSFileManagerDirectoryAdditionsTests.m
//
//  Created by Florian Mielke on 20.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSFileManager+DirectoryAdditions.h"


@interface NSFileManager_DirectoryAdditionsTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) NSFileManager *sut;
@property (NS_NONATOMIC_IOSONLY) NSURL *applicationDocumentsDirectory;

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
    
    [self.sut fm_removeItemsFromDirectoryAtPath:testDirectoryPath];
    
    NSArray *contentsOfDirectory = [self.sut contentsOfDirectoryAtPath:testDirectoryPath error:nil];
    XCTAssertEqual([contentsOfDirectory count], (NSUInteger)0);
}


- (void)testManagerShouldReturnApplicationDocumentsDirectory
{
    XCTAssertEqualObjects([self.sut fm_applicationDocumentsDirectory], self.applicationDocumentsDirectory);
}


- (void)testManagerShouldReturnApplicationInboxDirectory
{

    NSURL *inboxDir = [self.applicationDocumentsDirectory URLByAppendingPathComponent:@"Inbox" isDirectory:YES];
    
    XCTAssertEqualObjects([self.sut fm_applicationInboxDirectory], inboxDir);
}


@end
