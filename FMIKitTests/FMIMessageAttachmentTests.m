//
//  Created by Florian Mielke on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMIMessageAttachment.h"


@interface FMIMessageAttachmentTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIMessageAttachment *sut;
@property (NS_NONATOMIC_IOSONLY) NSData *sampleData;
@property (copy, NS_NONATOMIC_IOSONLY) NSString *sampleFileName;
@property (copy, NS_NONATOMIC_IOSONLY) NSString *sampleMIMEType;

@end



@implementation FMIMessageAttachmentTests


#pragma mark -
#pragma mark Fixture

- (void)setUp
{
    [super setUp];
    
    _sampleMIMEType = @"text/text";
    _sampleFileName = @"fileName";
    _sampleData = [[self sampleMIMEType] dataUsingEncoding:NSUTF8StringEncoding];
    
    _sut = [FMIMessageAttachment messageAttachmentForData:[self sampleData] mimeType:[self sampleMIMEType] fileName:[self sampleFileName]];
}


- (void)tearDown
{
    _sut = nil;
    
    [super tearDown];
}



#pragma mark -
#pragma mark Initialization

- (void)testMessageAttachmentIsNilForInvalidParameter
{
    XCTAssertNil([FMIMessageAttachment messageAttachmentForData:nil mimeType:nil fileName:nil]);
}


- (void)testMessageAttachmentHasAData
{
    XCTAssertEqualObjects([[self sut] data], [self sampleData]);
}


- (void)testMessageAttachmentHasAMIMTEType
{
    XCTAssertEqualObjects([[self sut] mimeType], [self sampleMIMEType]);
}


- (void)testMessageAttachmentHasAFileName
{
    XCTAssertEqualObjects([[self sut] fileName], [self sampleFileName]);
}


@end
