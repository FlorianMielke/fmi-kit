//
//  NSString+FileNameTests.m
//
//  Created by Florian Mielke on 08.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSString+FileName.h"


@interface NSString_FileNameTests : XCTestCase

@property (strong, nonatomic) NSString *invalidFileName;
@property (strong, nonatomic) NSString *validFileName;

@end



@implementation NSString_FileNameTests


#pragma mark -
#pragma mark Fixture

- (void)setUp
{
    [super setUp];
    
    _invalidFileName = @"Fi'leFron/t";
    _validFileName = @"FileFront.jpg";
}


- (void)tearDown
{
    [self setInvalidFileName:nil];
    [self setValidFileName:nil];
    
    [super tearDown];
}



#pragma mark -
#pragma mark Valid file name

- (void)testInvalidCharactersAreRemovedForValidFileName
{
    XCTAssertEqualObjects([[self invalidFileName] validFileName], @"FileFront");
}


- (void)testComputedFileNameContainsNameAndExtension
{
    // Given
    NSString *fileName = @"Dummy";
    
    // Then
    XCTAssertEqualObjects([fileName validFileNameWithType:@"ext"], @"Dummy.ext");
}


- (void)testComputedFileNameOnlyContainsNameWhenHavingNilExtension
{
    // Given
    NSString *fileName = @"Dummy";
    
    // Then
    XCTAssertEqualObjects([fileName validFileNameWithType:nil], @"Dummy");
}


- (void)testValidFileNameIsClippedWhenLongerThan150Characters
{
    // Given
    NSString *longFileName = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea taki";
    NSString *clippedFileName = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea tak";
    
    // Then
    XCTAssertEqualObjects([longFileName validFileName], clippedFileName);
}



#pragma mark -
#pragma mark Unique file name

- (void)testUniqueFileNameReturnsReceiverForEmptyListOfFileNames
{
    // When
    NSString *uniqueFileName = [[self validFileName] uniqueFileNameInFileNames:nil];
    
    // Then
    XCTAssertTrue([uniqueFileName isEqualToString:[self validFileName]]);
}


- (void)testUniqueFileNameReturnsReceiverIfFileNameIsAlreadyUnique
{
    // Given
    NSArray *fileNames = [NSArray arrayWithObjects:@"Lorem", @"Ipsum", nil];
    
    // When
    NSString *uniqueFileName = [[self validFileName] uniqueFileNameInFileNames:fileNames];
    
    // Then
    XCTAssertTrue([uniqueFileName isEqualToString:[self validFileName]]);
}


- (void)testUniqueFileNameRetursReceiverWhenHavingNoPathExtension
{
    // Given
    NSString *fileName = @"Lorem";
    NSArray *fileNames = [NSArray arrayWithObjects:@"Lorem.jpg", @"Ipsum.jpg", nil];
    
    // When
    NSString *uniqueFileName = [fileName uniqueFileNameInFileNames:fileNames];
    
    // Then
    XCTAssertTrue([uniqueFileName isEqualToString:fileName]);
}


- (void)testUniqueFileNameReturnsReceiverWithSuffixWhenHavingNoPathExtension
{
    // Given
    NSString *fileName = @"FileFront";
    NSArray *fileNames = [NSArray arrayWithObjects:@"FileFront", @"Ipsum", nil];
    
    // When
    NSString *uniqueFileName = [fileName uniqueFileNameInFileNames:fileNames];
    
    // Then
    XCTAssertTrue([uniqueFileName isEqualToString:@"FileFront 1"]);
}


- (void)testUniqueFileNameReturnsReceiverWithSuffix
{
    // Given
    NSArray *fileNames = [NSArray arrayWithObjects:@"FileFront.jpg", @"Ipsum.jpg", nil];
    
    // When
    NSString *uniqueFileName = [[self validFileName] uniqueFileNameInFileNames:fileNames];
    
    // Then
    XCTAssertTrue([uniqueFileName isEqualToString:@"FileFront 1.jpg"]);
}


- (void)testUniqueFileNameReturnsReceiverWithIncreasedSuffix
{
    // Given
    NSArray *fileNames = [NSArray arrayWithObjects:@"FileFront.jpg", @"FileFront 1.jpg", nil];
    
    // When
    NSString *uniqueFileName = [[self validFileName] uniqueFileNameInFileNames:fileNames];
    
    // Then
    XCTAssertTrue([uniqueFileName isEqualToString:@"FileFront 2.jpg"]);
}


@end
