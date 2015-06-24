//
//  NSString+FileNameTests.m
//
//  Created by Florian Mielke on 08.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSString+FileName.h"


@interface NSString_FileNameTests : XCTestCase

@property (strong, NS_NONATOMIC_IOSONLY) NSString *invalidFileName;
@property (strong, NS_NONATOMIC_IOSONLY) NSString *validFileName;

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

    NSString *fileName = @"Dummy";
    
    XCTAssertEqualObjects([fileName validFileNameWithType:@"ext"], @"Dummy.ext");
}


- (void)testComputedFileNameOnlyContainsNameWhenHavingNilExtension
{

    NSString *fileName = @"Dummy";
    
    XCTAssertEqualObjects([fileName validFileNameWithType:nil], @"Dummy");
}


- (void)testValidFileNameIsClippedWhenLongerThan150Characters
{

    NSString *longFileName = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea taki";
    NSString *clippedFileName = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea tak";
    
    XCTAssertEqualObjects([longFileName validFileName], clippedFileName);
}



#pragma mark -
#pragma mark Unique file name

- (void)testUniqueFileNameReturnsReceiverForEmptyListOfFileNames
{
    // When
    NSString *uniqueFileName = [[self validFileName] uniqueFileNameInFileNames:nil];
    
    XCTAssertTrue([uniqueFileName isEqualToString:[self validFileName]]);
}


- (void)testUniqueFileNameReturnsReceiverIfFileNameIsAlreadyUnique
{

    NSArray *fileNames = @[@"Lorem", @"Ipsum"];
    
    NSString *uniqueFileName = [[self validFileName] uniqueFileNameInFileNames:fileNames];
    
    XCTAssertTrue([uniqueFileName isEqualToString:[self validFileName]]);
}


- (void)testUniqueFileNameRetursReceiverWhenHavingNoPathExtension
{

    NSString *fileName = @"Lorem";
    NSArray *fileNames = @[@"Lorem.jpg", @"Ipsum.jpg"];
    
    NSString *uniqueFileName = [fileName uniqueFileNameInFileNames:fileNames];
    
    XCTAssertTrue([uniqueFileName isEqualToString:fileName]);
}


- (void)testUniqueFileNameReturnsReceiverWithSuffixWhenHavingNoPathExtension
{

    NSString *fileName = @"FileFront";
    NSArray *fileNames = @[@"FileFront", @"Ipsum"];
    
    NSString *uniqueFileName = [fileName uniqueFileNameInFileNames:fileNames];
    
    XCTAssertTrue([uniqueFileName isEqualToString:@"FileFront 1"]);
}


- (void)testUniqueFileNameReturnsReceiverWithSuffix
{

    NSArray *fileNames = @[@"FileFront.jpg", @"Ipsum.jpg"];
    
    NSString *uniqueFileName = [[self validFileName] uniqueFileNameInFileNames:fileNames];
    
    XCTAssertTrue([uniqueFileName isEqualToString:@"FileFront 1.jpg"]);
}


- (void)testUniqueFileNameReturnsReceiverWithIncreasedSuffix
{

    NSArray *fileNames = @[@"FileFront.jpg", @"FileFront 1.jpg"];
    
    NSString *uniqueFileName = [[self validFileName] uniqueFileNameInFileNames:fileNames];
    
    XCTAssertTrue([uniqueFileName isEqualToString:@"FileFront 2.jpg"]);
}


@end
