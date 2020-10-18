//
//  NSString+FileNameTests.m
//
//  Created by Florian Mielke on 08.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+FileName.h"

@interface NSString_FileNameTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) NSString *invalidFileName;
@property (NS_NONATOMIC_IOSONLY) NSString *validFileName;

@end

@implementation NSString_FileNameTests

- (void)setUp {
    [super setUp];
    self.invalidFileName = @"Fi'leFron/t";
    self.validFileName = @"FileFront.jpg";
}

- (void)tearDown {
    self.invalidFileName = nil;
    self.validFileName = nil;
    [super tearDown];
}

#pragma mark - Valid file name

- (void)testInvalidCharactersAreRemovedForValidFileName {
    XCTAssertEqualObjects([[self invalidFileName] validFileName], @"FileFront");
}

- (void)testComputedFileNameContainsNameAndExtension {
    NSString *fileName = @"Dummy";
    XCTAssertEqualObjects([fileName validFileNameWithType:@"ext"], @"Dummy.ext");
}

- (void)testComputedFileNameOnlyContainsNameWhenHavingNilExtension {
    NSString *fileName = @"Dummy";
    XCTAssertEqualObjects([fileName validFileNameWithType:nil], @"Dummy");
}

- (void)testValidFileNameIsClippedWhenLongerThan150Characters {
    NSString *longFileName = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea taki";
    NSString *clippedFileName = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea tak";
    
    XCTAssertEqualObjects([longFileName validFileName], clippedFileName);
}

#pragma mark - Unique file name

- (void)testUniqueFileNameReturnsReceiverForEmptyListOfFileNames {
    NSString *uniqueFileName = [self.validFileName uniqueFileNameInFileNames:nil];
    XCTAssertEqualObjects(self.validFileName, uniqueFileName);
}

- (void)testUniqueFileNameReturnsReceiverIfFileNameIsAlreadyUnique {
    NSString *uniqueFileName = [self.validFileName uniqueFileNameInFileNames:@[@"Lorem", @"Ipsum"]];
    XCTAssertEqualObjects(self.validFileName, uniqueFileName);
}

- (void)testUniqueFileNameReturnsReceiverWhenHavingNoPathExtension {
    NSString *uniqueFileName = [@"Lorem" uniqueFileNameInFileNames:@[@"Lorem.jpg", @"Ipsum.jpg"]];
    XCTAssertEqualObjects(@"Lorem", uniqueFileName);
}

- (void)testUniqueFileNameReturnsReceiverWithSuffixWhenHavingNoPathExtension {
    NSString *uniqueFileName = [@"FileFront" uniqueFileNameInFileNames:@[@"FileFront", @"Ipsum"]];
    XCTAssertEqualObjects(@"FileFront 1", uniqueFileName);
}

- (void)testUniqueFileNameReturnsReceiverWithSuffix {
    NSString *uniqueFileName = [self.validFileName uniqueFileNameInFileNames:@[@"FileFront.jpg", @"Ipsum.jpg"]];
    XCTAssertEqualObjects(@"FileFront 1.jpg", uniqueFileName);
}

- (void)testUniqueFileNameReturnsReceiverWithIncreasedSuffix {
    NSString *uniqueFileName = [self.validFileName uniqueFileNameInFileNames:@[@"FileFront.jpg", @"FileFront 1.jpg"]];
    XCTAssertEqualObjects(@"FileFront 2.jpg", uniqueFileName);

    uniqueFileName = [self.validFileName uniqueFileNameInFileNames:@[@"FileFront.jpg", @"FileFront 1.jpg", @"FileFront 3.jpg"]];
    XCTAssertEqualObjects(@"FileFront 2.jpg", uniqueFileName);

    uniqueFileName = [@"A.jpg" uniqueFileNameInFileNames:@[@"A.jpg", @"A 1.jpg", @"A 2.jpg", @"A 3.jpg", @"A 4.jpg", @"A 5.jpg", @"A 6.jpg", @"A 7.jpg", @"A 8.jpg", @"A 9.jpg", @"A 10.jpg"]];
    XCTAssertEqualObjects(@"A 11.jpg", uniqueFileName);
}

@end
