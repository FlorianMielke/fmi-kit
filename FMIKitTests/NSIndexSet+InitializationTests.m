#import <XCTest/XCTest.h>
#import "NSIndexSet+Initialization.h"

@interface NSIndexSetInitializationAdditionsTests : XCTestCase

@end

@implementation NSIndexSetInitializationAdditionsTests

- (void)testReturnsEmptyIndexSetForNilArray {
    NSIndexSet *indexes = [NSIndexSet fmi_indexSetFromNumbersInArray:nil];

    XCTAssertEqual(0, indexes.count);
}

- (void)testReturnsEmptyIndexSetForEmptyArray {
    NSIndexSet *indexes = [NSIndexSet fmi_indexSetFromNumbersInArray:@[]];

    XCTAssertEqual(0, indexes.count);
}

- (void)testReturnsEmptyIndexSetForInvalidArray {
    NSArray *array = @[@"Lorem", @"Ipsum", @2];

    NSIndexSet *indexes = [NSIndexSet fmi_indexSetFromNumbersInArray:array];

    NSIndexSet *expected = [NSIndexSet indexSetWithIndex:2];
    XCTAssertEqualObjects(expected, indexes);
}

- (void)testReturnsIndexSetWithIndexes {
    NSArray *array = @[@1, @2, @4];

    NSIndexSet *indexes = [NSIndexSet fmi_indexSetFromNumbersInArray:array];

    NSMutableIndexSet *expected = [NSMutableIndexSet indexSet];
    [expected addIndex:1];
    [expected addIndex:2];
    [expected addIndex:4];
    XCTAssertEqualObjects(expected, indexes);
}

@end
