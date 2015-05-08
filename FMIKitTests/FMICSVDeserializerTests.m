//
//  Created by Florian Mielke on 02.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "FMICSVDeserializer.h"
#import "FakeCSVFileDescription.h"


@interface SLSCSVDeserializerTests : XCTestCase

@property (nonatomic, strong) FakeCSVFileDescription *fileDescription;
@property (nonatomic, strong) NSURL *validTestFileURL;
@property (nonatomic, strong) NSURL *invalidTestFileURL;

@end



@implementation SLSCSVDeserializerTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];
    
    self.fileDescription = [[FakeCSVFileDescription alloc] init];
    self.fileDescription.delimiter = @";";
    self.fileDescription.encloser = nil;
    
    NSString *validTestFileBundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"TestFile" ofType:@"csv"];
    self.validTestFileURL = [NSURL fileURLWithPath:validTestFileBundlePath];
    
    NSString *invalidTestFileBundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"TestFileInvalid" ofType:@"csv"];
    self.invalidTestFileURL = [NSURL fileURLWithPath:invalidTestFileBundlePath];
}


- (void)tearDown
{
    self.fileDescription = nil;
    self.validTestFileURL = nil;
    self.invalidTestFileURL = nil;
    
    [super tearDown];
}



#pragma mark - Tests

- (void)testValidationShouldSucceedForValidURL
{
    XCTAssertTrue([FMICSVDeserializer isValidCSVFileAtURL:self.validTestFileURL fileDescription:self.fileDescription error:NULL]);
}


- (void)testValidationShouldFailForNilURL
{
    XCTAssertFalse([FMICSVDeserializer isValidCSVFileAtURL:nil fileDescription:self.fileDescription error:NULL]);
}


- (void)testValidationShouldFailForInvalidFileAtURL
{
    XCTAssertFalse([FMICSVDeserializer isValidCSVFileAtURL:self.invalidTestFileURL fileDescription:self.fileDescription error:NULL]);
}


- (void)testValidationShouldReturnErrorForInvalidFileAtURL
{
    // Given
    NSError *error;
    
    // When
    BOOL isValid = [FMICSVDeserializer isValidCSVFileAtURL:self.invalidTestFileURL fileDescription:self.fileDescription error:&error];
    
    // Then
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, FMICSVDeserializerErrorDomain);
    XCTAssertEqual(error.code, FMICSVDeserializerInvalidLineEndingError);
}


- (void)testValidationShouldFailForInvalidLineBreak
{
    // Given
    self.fileDescription.lineBreak = @"\r";
    
    // Then
    XCTAssertFalse([FMICSVDeserializer isValidCSVFileAtURL:self.invalidTestFileURL fileDescription:self.fileDescription error:NULL]);
}


- (void)testDeserializationShouldReturn9Components
{
    // When
    NSArray *components = [FMICSVDeserializer objectsWithContentsOfFileAtURL:self.validTestFileURL fileDescription:self.fileDescription error:NULL];
    
    // Then
    XCTAssertEqual([components count], (NSUInteger)1415);
}


- (void)testDeserializationShouldReturnComponentsForFirstRow
{
    // Given
    NSDictionary *referenceObject = @{@"caption" : @"Organisation von Finanzberater Nachname_1"
                                      , @"color" : @"150,54,52"
                                      , @"employeeNo" : @36975
                                      , @"firstName" : @"Vorname_1"
                                      , @"lastName" : @"Nachname_1"
                                      , @"managerEmployeeNo" : @45856
                                      , @"salutation" : @"Herr"
                                      , @"title" : @"FB"
                                      , @"titleLong" : @"Finanzberater"
                                      , @"unitValue" : @26873
                                      , @"unitValuePriorYear": @28940};
    
    // When
    NSArray *components = [FMICSVDeserializer objectsWithContentsOfFileAtURL:self.validTestFileURL fileDescription:self.fileDescription error:NULL];
    
    // Then
    XCTAssertEqualObjects([components firstObject], referenceObject);
}


- (void)testDeserializationShouldAssignDefaultValues
{
    // Given
    NSDictionary *defaultValuesObject = @{@"caption" : @""
                                          , @"color" : @"161,28,54"
                                          , @"employeeNo" : @1
                                          , @"firstName" : @""
                                          , @"lastName" : @""
                                          , @"managerEmployeeNo" : @1
                                          , @"salutation" : @"Herr"
                                          , @"title" : @""
                                          , @"titleLong" : @""
                                          , @"unitValue" : @0
                                          , @"unitValuePriorYear": @0};
    
    // When
    NSArray *components = [FMICSVDeserializer objectsWithContentsOfFileAtURL:self.validTestFileURL fileDescription:self.fileDescription error:NULL];
    
    // Then
    XCTAssertEqualObjects([components lastObject], defaultValuesObject);
}


@end
