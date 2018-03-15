#import <XCTest/XCTest.h>
#import "FMIMultilevelList.h"
#import "FMIMultilevelListNumber.h"
#import "FMIMultilevelListItem.h"

@interface FakeMultilevelListItem : NSObject <FMIMultilevelListItem>

@property (NS_NONATOMIC_IOSONLY) FMIMultilevelListNumber *listNumber;

@end

@implementation FakeMultilevelListItem
@end

@interface FMIMultilevelTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIMultilevelList *subject;
@property (NS_NONATOMIC_IOSONLY) NSMutableArray *list;
@property (NS_NONATOMIC_IOSONLY) FakeMultilevelListItem *fakeListItemOne;
@property (NS_NONATOMIC_IOSONLY) FakeMultilevelListItem *fakeListItemTwo;
@property (NS_NONATOMIC_IOSONLY) FakeMultilevelListItem *fakeListItemThree;

@end

@implementation FMIMultilevelTest

- (void)setUp {
    [super setUp];
    self.fakeListItemOne = [[FakeMultilevelListItem alloc] init];
    self.fakeListItemOne.listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"1"];
    self.fakeListItemTwo = [[FakeMultilevelListItem alloc] init];
    self.fakeListItemTwo.listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"2"];
    self.fakeListItemThree = [[FakeMultilevelListItem alloc] init];
    self.fakeListItemThree.listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"3"];
    self.list = [@[self.fakeListItemOne, self.fakeListItemTwo, self.fakeListItemThree] mutableCopy];
    self.subject = [[FMIMultilevelList alloc] initWithItems:self.list];
}

- (void)testListShouldBeInitialized {
    XCTAssertNotNil(self.subject);
    XCTAssertEqualObjects(self.list, self.subject.items);
}

- (void)testListShouldMoveItemUp {
    [self.subject moveItem:self.fakeListItemTwo fromIndex:1 toIndex:0 indentationLevel:0];

    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"2"], self.fakeListItemOne.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"1"], self.fakeListItemTwo.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"3"], self.fakeListItemThree.listNumber);

    NSArray *sortedListItems = @[self.fakeListItemTwo, self.fakeListItemOne, self.fakeListItemThree];
    XCTAssertEqualObjects(sortedListItems, self.subject.items);
}

- (void)testListShouldUnindentItemWhenMoveItemToPosition1Indented {
    [self.subject moveItem:self.fakeListItemTwo fromIndex:1 toIndex:0 indentationLevel:1];

    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"2"], self.fakeListItemOne.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"1"], self.fakeListItemTwo.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"3"], self.fakeListItemThree.listNumber);

    NSArray *sortedListItems = @[self.fakeListItemTwo, self.fakeListItemOne, self.fakeListItemThree];
    XCTAssertEqualObjects(sortedListItems, self.subject.items);
}

- (void)testListShouldMoveItemDown {
    [self.subject moveItem:self.fakeListItemTwo fromIndex:1 toIndex:2 indentationLevel:0];

    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"1"], self.fakeListItemOne.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"3"], self.fakeListItemTwo.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"2"], self.fakeListItemThree.listNumber);

    NSArray *sortedListItems = @[self.fakeListItemOne, self.fakeListItemThree, self.fakeListItemTwo];
    XCTAssertEqualObjects(sortedListItems, self.subject.items);
}

- (void)testListShouldIndentItem {
    [self.subject moveItem:self.fakeListItemTwo fromIndex:1 toIndex:1 indentationLevel:1];

    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"1"], self.fakeListItemOne.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"1.1"], self.fakeListItemTwo.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"2"], self.fakeListItemThree.listNumber);

    NSArray *sortedActionItems = @[self.fakeListItemOne, self.fakeListItemTwo, self.fakeListItemThree];
    XCTAssertEqualObjects(sortedActionItems, self.subject.items);
}

- (void)testListShouldIndentItemToSubPosition10 {
    for (NSUInteger i = 1; i <= 11; i++) {
        FakeMultilevelListItem *listItem = [[FakeMultilevelListItem alloc] init];
        NSString *stringValue = [NSString stringWithFormat:@"3.%lu", (unsigned long) i];
        listItem.listNumber = [FMIMultilevelListNumber listNumberFromStringValue:stringValue];
        [self.list addObject:listItem];
    }

    FMIMultilevelList *list = [[FMIMultilevelList alloc] initWithItems:self.list];
    [list moveItem:self.fakeListItemTwo fromIndex:1 toIndex:12 indentationLevel:1];

    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"2.11"], self.fakeListItemTwo.listNumber);
}

- (void)testListShouldUnIndentItem {
    [self.subject moveItem:self.fakeListItemTwo fromIndex:1 toIndex:1 indentationLevel:1];
    [self.subject moveItem:self.fakeListItemTwo fromIndex:1 toIndex:1 indentationLevel:0];

    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"1"], self.fakeListItemOne.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"2"], self.fakeListItemTwo.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"3"], self.fakeListItemThree.listNumber);
}

- (void)testListShouldNotIndentItemWhenBeingMovedToTheBeginning {
    [self.subject moveItem:self.fakeListItemTwo fromIndex:1 toIndex:0 indentationLevel:1];

    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"2"], self.fakeListItemOne.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"1"], self.fakeListItemTwo.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"3"], self.fakeListItemThree.listNumber);
}

- (void)testListShouldUnIndentItemWhenBeingMovedToTheBeginning {
    [self.subject moveItem:self.fakeListItemTwo fromIndex:1 toIndex:1 indentationLevel:1];
    [self.subject moveItem:self.fakeListItemOne fromIndex:0 toIndex:1 indentationLevel:0];

    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"2"], self.fakeListItemOne.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"1"], self.fakeListItemTwo.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"3"], self.fakeListItemThree.listNumber);
}

- (void)testListShouldDoNothingWhenRemovingItemThatsNotAnItemOfTheList {
    FakeMultilevelListItem *item = [[FakeMultilevelListItem alloc] init];
    [self.subject removeItem:item];
    XCTAssertEqualObjects(self.subject.items, self.list);
}

- (void)testListShouldRemoveItemAndRenumberRemainigItems {
    [self.subject removeItem:self.fakeListItemTwo];

    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"1"], self.fakeListItemOne.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"2"], self.fakeListItemThree.listNumber);

    NSArray *newListItems = @[self.fakeListItemOne, self.fakeListItemThree];
    XCTAssertEqualObjects(newListItems, self.subject.items);
}

- (void)testListShouldNotRenumberItemsWhenRemovingTheLastItem {
    FMIMultilevelList *list = [[FMIMultilevelList alloc] initWithItems:@[self.fakeListItemOne]];
    [list removeItem:self.fakeListItemOne];
    XCTAssertEqualObjects(@[], list.items);
}

- (void)testListInsertsNewItemInEmptyList {
    FMIMultilevelList *subject = [[FMIMultilevelList alloc] initWithItems:@[]];

    [subject insertItem:self.fakeListItemThree atIndex:0];

    NSArray *expected = @[self.fakeListItemThree];
    XCTAssertEqualObjects(expected, subject.items);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"1"], self.fakeListItemThree.listNumber);
}

- (void)testListInsertsNewItemInListWithOneItem {
    FMIMultilevelList *subject = [[FMIMultilevelList alloc] initWithItems:@[self.fakeListItemOne]];

    [subject insertItem:self.fakeListItemThree atIndex:1];

    NSArray *expected = @[self.fakeListItemOne, self.fakeListItemThree];
    XCTAssertEqualObjects(expected, subject.items);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"2"], self.fakeListItemThree.listNumber);
}

- (void)testListInsertsNewItemInListWithManyItems {
    FakeMultilevelListItem *listItemFour = [[FakeMultilevelListItem alloc] init];
    listItemFour.listNumber = [FMIMultilevelListNumber listNumberFromStringValue:@"3"];
    FMIMultilevelList *subject = [[FMIMultilevelList alloc] initWithItems:@[self.fakeListItemOne, self.fakeListItemTwo, listItemFour]];
    
    [subject insertItem:self.fakeListItemThree atIndex:2];
    
    NSArray *expected = @[self.fakeListItemOne, self.fakeListItemTwo, self.fakeListItemThree, listItemFour];
    XCTAssertEqualObjects(expected, subject.items);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"3"], self.fakeListItemThree.listNumber);
    XCTAssertEqualObjects([FMIMultilevelListNumber listNumberFromStringValue:@"4"], listItemFour.listNumber);
}

@end
