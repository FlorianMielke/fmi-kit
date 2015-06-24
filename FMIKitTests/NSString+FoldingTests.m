//
//  NSString+FoldingTests.m
//
//  Created by Florian on 12.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "NSString+Folding.h"


@interface NSString (FoldingTest)

+ (NSString *)substringFromData:(NSData *)stringData inRange:(NSRange)range encoding:(NSStringEncoding)encoding;

@end



@interface NSString_FoldingTests : XCTestCase


@end



@implementation NSString_FoldingTests


#pragma mark -
#pragma mark Fold text

- (void)testFoldingTextReturnsTheSameStringFor0Octets
{
    XCTAssertEqualObjects([@"Lorem ipsum." stringByFoldingToOctects:0], @"Lorem ipsum.");
}


- (void)testFoldedTextLinesAreNotLongerThan75Octets
{
    XCTAssertEqualObjects([@"Lorem ipsum." stringByFoldingToOctects:75], @"Lorem ipsum.");
}


- (void)testFoldingTextReturnsNewString
{

    NSString *longText = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";
    
    NSString *foldedText = [longText stringByFoldingToOctects:75];
    
    XCTAssertNotNil(foldedText);
}


- (void)testFoldingTextDoesNotAddALeadingWhitespaceInTheFirstLine
{

    NSString *longText = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";

    // When
    NSString *foldedText = [longText stringByFoldingToOctects:75];
    
    XCTAssertTrue([foldedText hasPrefix:@"Lorem"]);
}


- (void)testFoldingTextLineHaveLeadingWhitespaceExceptForTheFirstLine
{

    NSString *longText = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";
    NSString *foldedText = [longText stringByFoldingToOctects:75];
    
    __block BOOL hasLeadingWhitespace = NO;
    __block BOOL isFirstLine = YES;
    
    [foldedText enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
        
        if (isFirstLine)
        {
            isFirstLine = NO;
        }
        else
        {
            hasLeadingWhitespace = ([line hasPrefix:@" "]);
            if (!hasLeadingWhitespace) {
                *stop = YES;
            }
        }
        
    }];
    
    XCTAssertTrue(hasLeadingWhitespace);
}


- (void)testFoldingTextLinesAreNotLongerThan75Octets
{

    NSString *longText = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";
    NSString *foldedText = [longText stringByFoldingToOctects:75];
    
    __block BOOL longerThan75Octets = YES;
    
    [foldedText enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {

        longerThan75Octets = ([[line dataUsingEncoding:NSUTF8StringEncoding] length] > 75);
        if (!longerThan75Octets) {
            *stop = YES;
        }
        
    }];
    
    XCTAssertFalse(longerThan75Octets);
}


- (void)testFoldingTextLinesCalculatesRemainderForLastLine
{

    NSString *longText = @"Lorem ipsum dolor sit amet.";
    NSString *foldedText = [longText stringByFoldingToOctects:17];
    
    __block BOOL isFirstLine = YES;
    __block NSString *lastLine = nil;
    
    [foldedText enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {

        if (isFirstLine) {
            isFirstLine = NO;
        } else {
            lastLine = line;
        }
        
    }];
    
    XCTAssertEqualObjects(lastLine, @" r sit amet.");
}



#pragma mark -
#pragma mark Substring from data

- (void)testSubstringFromDataReturnsNilForNilData
{
    XCTAssertNil([NSString substringFromData:nil inRange:NSMakeRange(0, 15) encoding:NSUTF8StringEncoding]);
}


- (void)testSubstringFromDataReturnsNilFor0RangeLength
{

    NSString *sampleString = @"Lorem ipsum.";
    NSData *sampleStringData = [sampleString dataUsingEncoding:NSUTF8StringEncoding];
    
    XCTAssertNil([NSString substringFromData:sampleStringData inRange:NSMakeRange(5, 0) encoding:NSUTF8StringEncoding]);
}


- (void)testSubstringFromDataReturnsNilForOutOfRange
{

    NSString *sampleString = @"Lorem ipsum.";
    NSData *sampleStringData = [sampleString dataUsingEncoding:NSUTF8StringEncoding];
    
    XCTAssertNil([NSString substringFromData:sampleStringData inRange:NSMakeRange(15, 5) encoding:NSUTF8StringEncoding]);
}


- (void)testSubstringFromDataReturnsCorrectSubstringForRange
{

    NSString *sampleString = @"Lorem ipÁsum.";
    NSData *sampleStringData = [sampleString dataUsingEncoding:NSUTF8StringEncoding];

    // Then
    XCTAssertEqualObjects([NSString substringFromData:sampleStringData inRange:NSMakeRange(0, 5) encoding:NSUTF8StringEncoding], @"Lorem");
}




@end