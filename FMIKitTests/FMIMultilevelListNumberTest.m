#import <XCTest/XCTest.h>
#import "FMIMultilevelListNumber.h"

@interface FMIMultilevelListNumberTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIMultilevelListNumber *subject;

@end

@implementation FMIMultilevelListNumberTest

- (void)setUp {
    [super setUp];
    self.subject = [FMIMultilevelListNumber listNumberFromStringValue:@"1"];
}

- (void)testListNumberShouldBeInitializedWithString {
    FMIMultilevelListNumber *listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"0"];
    XCTAssertEqualObjects(@"0", listNumber.stringValue);
}

- (void)testListNumberShouldNotBeInitializedWithoutString {
    XCTAssertNil([FMIMultilevelListNumber listNumberFromStringValue:nil]);
}

- (void)testListNumberShouldBeInitializedWithStringFromFactoryMethod {
    XCTAssertEqualObjects(@"1", self.subject.stringValue);
}

- (void)testListNumberShouldBeInitializedWithNumbers {
    FMIMultilevelListNumber *listNumber = [FMIMultilevelListNumber listNumberFromComponents:@[@1, @2]];
    XCTAssertEqualObjects(@"1.2", listNumber.stringValue);
}

- (void)testListNumberShouldNotBeInitializedWithoutNumbers {
    XCTAssertNil([FMIMultilevelListNumber listNumberFromComponents:@[]]);
}

- (void)testListNumberShouldBeInitializedWithNumbersFromFactoryMethod {
    FMIMultilevelListNumber *listNumber = [FMIMultilevelListNumber listNumberFromComponents:@[@1]];
    XCTAssertEqualObjects(@"1", listNumber.stringValue);
}

- (void)testListNumberShouldReturnItsListNumberComponents {
    FMIMultilevelListNumber *listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"1"];
    NSArray *numberComponents = listNumber.components;
    XCTAssertEqualObjects(@1, numberComponents[0]);
    XCTAssertEqual((NSUInteger) 1, numberComponents.count);
}

- (void)testListNumberShouldReturnItsListNumberComponentsForIndentedItem {
    FMIMultilevelListNumber *listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"1.2"];
    NSArray *numberComponents = listNumber.components;
    XCTAssertEqualObjects(@1, numberComponents[0]);
    XCTAssertEqualObjects(@2, numberComponents[1]);
    XCTAssertEqual((NSUInteger) 2, numberComponents.count);
}

- (void)testListNumberShouldReturnIndentationLevel {
    FMIMultilevelListNumber *listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"1"];
    XCTAssertEqual((NSUInteger) 0, listNumber.indentationLevel);
}

- (void)testListNumberShouldBeEqualToSelf {
    FMIMultilevelListNumber *listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"1"];
    XCTAssertTrue([listNumber isEqual:listNumber]);
}

- (void)testListNumberShouldBeEqualToListNumberWithSameStringValue {
    FMIMultilevelListNumber *listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"1"];
    XCTAssertTrue([self.subject isEqual:listNumber]);
}

- (void)testDurationShouldNotBeEqualToDurationWithDifferentStringValue {
    FMIMultilevelListNumber *listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"1.1"];
    XCTAssertFalse([self.subject isEqual:listNumber]);
}

- (void)testComparingListNumbers {
    FMIMultilevelListNumber *number = [FMIMultilevelListNumber listNumberFromStringValue:@"1"];
    FMIMultilevelListNumber *sameNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"1"];
    FMIMultilevelListNumber *smallerNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"0.1"];
    FMIMultilevelListNumber *biggerNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"2"];
    FMIMultilevelListNumber *biggerNumberDecimal = [FMIMultilevelListNumber listNumberFromStringValue:@"2.1"];

    XCTAssertEqual([number compare:sameNumber], NSOrderedSame);
    XCTAssertEqual([number compare:smallerNumber], NSOrderedDescending);
    XCTAssertEqual([number compare:biggerNumber], NSOrderedAscending);
    XCTAssertEqual([number compare:biggerNumberDecimal], NSOrderedAscending);
    XCTAssertEqual([biggerNumberDecimal compare:biggerNumber], NSOrderedDescending);
}

@end