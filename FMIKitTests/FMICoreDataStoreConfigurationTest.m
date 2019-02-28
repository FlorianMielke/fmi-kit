#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <CoreData/CoreData.h>
#import "FMICoreDataStoreConfiguration.h"

@interface FMICoreDataStoreConfigurationTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMICoreDataStoreConfiguration *subject;
@property (NS_NONATOMIC_IOSONLY) NSURL *localStoreURL;
@property (NS_NONATOMIC_IOSONLY) NSDictionary *localStoreOptions;

@end

@implementation FMICoreDataStoreConfigurationTest

- (void)setUp {
  [super setUp];
  NSURL *managedObjectModelURL = OCMClassMock([NSManagedObjectModel class]);
  self.localStoreURL = [[NSURL alloc] initFileURLWithPath:@"::localPath::"];
  self.localStoreOptions = @{@"::option::": @"::local::"};
  self.subject = [[FMICoreDataStoreConfiguration alloc] initWithManagedObjectModelURL:managedObjectModelURL localStoreURL:self.localStoreURL localStoreOptions:self.localStoreOptions];
}

- (void)tearDown {
  self.subject = nil;
  self.localStoreOptions = nil;
  self.localStoreURL = nil;
  [super tearDown];
}

- (void)testItReturnsTheCurrentLocalStoreURL {
  XCTAssertEqualObjects(self.localStoreURL, self.subject.currentStoreURL);
}

- (void)testItReturnsTheCurrentLocalStoreOptions {
  XCTAssertEqualObjects(self.localStoreOptions, self.subject.currentStoreOptions);
}

@end
