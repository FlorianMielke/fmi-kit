//
//  Created by Florian Mielke on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMIMessageMIMETypes.h"

@interface FMIMessageMIMETypesTests : XCTestCase

@end

@implementation FMIMessageMIMETypesTests

- (void)testMIMETypesAlwaysReturnsSameDictionary {
    NSDictionary *mimeTypesOne = [FMIMessageMIMETypes mimeTypes];
    NSDictionary *mimeTypesTwo = [FMIMessageMIMETypes mimeTypes];
    XCTAssertEqualObjects(mimeTypesOne, mimeTypesTwo);
}

- (void)testMIMETypesReturns764Records {
    XCTAssertEqual([[[FMIMessageMIMETypes mimeTypes] allKeys] count], (NSUInteger)764);
}

- (void)testSearchingForNilExtensionReturnsUnkownMIMEType {
    XCTAssertEqualObjects([FMIMessageMIMETypes mimeTypeForFileExtension:nil], @"application/octet-stream");
}

- (void)testSearchingForInvalidExtensionReturnsUnkownMIMEType {
    NSString *mimeType =[FMIMessageMIMETypes mimeTypeForFileExtension:@"12345"];
    XCTAssertEqualObjects(mimeType, @"application/octet-stream");
}

- (void)testSerachingForPDFExtensionReturnsPDFMIMEType {
    XCTAssertEqualObjects([FMIMessageMIMETypes mimeTypeForFileExtension:@"pdf"], @"application/pdf");
}

- (void)testSerachingForUppercasePDFExtensionReturnsPDFMIMEType {
    XCTAssertEqualObjects([FMIMessageMIMETypes mimeTypeForFileExtension:@"PDF"], @"application/pdf");
}

- (void)testSearchingForMultipleExtensionsReturnsMIMETypes {
    XCTAssertEqualObjects([FMIMessageMIMETypes mimeTypeForFileExtension:@"ics"], @"text/calendar");
    XCTAssertEqualObjects([FMIMessageMIMETypes mimeTypeForFileExtension:@"ifb"], @"text/calendar");
}

@end
