//
//  Created by Florian Mielke on 02.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "FMICSVFieldDeserializer.h"
#import "FMIFieldDescription.h"


@interface SLSCSVComponentsTests : XCTestCase

@property (nonatomic, strong) FMICSVFieldDeserializer *sut;

@end


@implementation SLSCSVComponentsTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];

    FMIFieldDescription *fieldDescription = [[FMIFieldDescription alloc] init];
    self.sut = [[FMICSVFieldDeserializer alloc] initWithFieldDescriptions:@[fieldDescription]];
}


- (void)tearDown
{
    self.sut = nil;
    
    [super tearDown];
}



#pragma mark - Tests

- (void)testFieldDeserializerShouldBeInitalized
{
    XCTAssertNotNil(self.sut);
}


- (void)testFieldDeserializerShouldAssignDefaultValue
{
    // Given
    FMIFieldDescription *fieldDescription = [[FMIFieldDescription alloc] init];
    fieldDescription.name = @"myField";
    fieldDescription.defaultValue = @"Lorem";
    fieldDescription.type = FMFieldTypeString;
    
    FMICSVFieldDeserializer *deserializer = [[FMICSVFieldDeserializer alloc] initWithFieldDescriptions:@[fieldDescription]];
    
    // When
    NSDictionary *fieldObjects = [deserializer objectsFromFields:@[@""]];
    
    // Then
    XCTAssertEqualObjects([fieldObjects valueForKey:@"myField"], @"Lorem");
}


- (void)testFieldDeserializerShouldConvertToNumber
{
    // Given
    FMIFieldDescription *fieldDescription = [[FMIFieldDescription alloc] init];
    fieldDescription.name = @"myField";
    fieldDescription.type = FMFieldTypeInteger64;
    
    FMICSVFieldDeserializer *deserializer = [[FMICSVFieldDeserializer alloc] initWithFieldDescriptions:@[fieldDescription]];
    
    // When
    NSDictionary *fieldObjects = [deserializer objectsFromFields:@[@"103"]];
    
    // Then
    XCTAssertEqualObjects([fieldObjects valueForKey:@"myField"], @103);
}




@end
