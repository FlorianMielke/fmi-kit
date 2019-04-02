#import <XCTest/XCTest.h>
#import "UITableView+IndexPath.h"
#import "FakeTableViewDataSource.h"

@interface UITableView_IndexPathTests : XCTestCase

@property (NS_NONATOMIC_IOSONLY) UITableView *subject;
@property (NS_NONATOMIC_IOSONLY) FakeTableViewDataSource *dataSource;

@end

@implementation UITableView_IndexPathTests

- (void)setUp {
  [super setUp];
  self.subject = [[UITableView alloc] init];
  self.dataSource = [[FakeTableViewDataSource alloc] init];
  [self.subject setDataSource:self.dataSource];
}

- (void)tearDown {
  self.subject = nil;
  self.dataSource = nil;
  [super tearDown];
}

- (void)testTableShouldReturnFalseForIsEmtpy {
  XCTAssertFalse([self.subject fm_isEmpty]);
}

- (void)testEmtpyTableShouldReturnTrueForEmptyTable {
  UITableView *table = [[UITableView alloc] init];
  
  XCTAssertTrue([table fm_isEmpty]);
}

- (void)testTableShouldReturnFirstIndexPath {
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  
  XCTAssertEqual([[self.subject fm_firstIndexPath] compare:indexPath], NSOrderedSame);
}

- (void)testEmtpyTableShouldReturnNilForFirstIndexPath {
  UITableView *table = [[UITableView alloc] init];
  
  XCTAssertNil([table fm_firstIndexPath]);
}

- (void)testTableShouldReturnLastIndexPath {
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:2];
  
  XCTAssertEqual([[self.subject fm_lastIndexPath] compare:indexPath], NSOrderedSame);
}

- (void)testEmtpyTableShouldReturnNilForLastIndexPath {
  UITableView *table = [[UITableView alloc] init];
  
  XCTAssertNil([table fm_lastIndexPath]);
}

- (void)testTableShouldReturnLastIndexPathOfFirstSection {
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
  
  XCTAssertEqual([[self.subject fm_lastIndexPathInSection:0] compare:indexPath], NSOrderedSame);
}

- (void)testTableViewShouldEnumerateIndexPaths {
  __block NSInteger numberOfRows = 0;
  
  [self.subject fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
    numberOfRows++;
  }];
  
  XCTAssertEqual(numberOfRows, 30);
}

- (void)testTableViewShouldPassIndexPathsDuringEnumeration {
  __block NSIndexPath *lastIndexPath = nil;
  
  [self.subject fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
    lastIndexPath = indexPath;
  }];
  
  XCTAssertTrue([lastIndexPath compare:[NSIndexPath indexPathForRow:9 inSection:2]] == NSOrderedSame);
}

- (void)testTableViewShouldStopEnumeration {
  __block NSIndexPath *stoppedIndexPath = nil;
  NSIndexPath *stoppingIndexPath = [NSIndexPath indexPathForRow:4 inSection:1];
  
  [self.subject fm_enumerateIndexPathsUsingBlock:^(NSIndexPath *indexPath, BOOL *stop) {
    stoppedIndexPath = indexPath;
    if ([stoppedIndexPath compare:stoppingIndexPath] == NSOrderedSame) {
      *stop = YES;
    }
  }];
  
  XCTAssertTrue([stoppedIndexPath compare:stoppingIndexPath] == NSOrderedSame);
}

@end
