#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <CoreData/CoreData.h>
#import "FMIFetchCloudStatus.h"
#import "FMIStoreConfiguration.h"

@interface FMIStoreConfigurationTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIStoreConfiguration *subject;
@property (NS_NONATOMIC_IOSONLY) FMIFetchCloudStatus *fetchCloudStatus;

@property (nonatomic, strong) NSURL *localStoreURL;
@property (nonatomic, strong) NSDictionary *localStoreOptions;
@property (nonatomic, strong) NSURL *cloudStoreURL;
@property (nonatomic, strong) NSDictionary *cloudStoreOptions;
@end

@implementation FMIStoreConfigurationTest

- (void)setUp {
    [super setUp];
    NSURL *managedObjectModelURL = OCMClassMock([NSManagedObjectModel class]);
    self.localStoreURL = [[NSURL alloc] initFileURLWithPath:@"::localPath::"];
    self.localStoreOptions = @{@"::option::": @"::local::"};
    self.cloudStoreURL = [[NSURL alloc] initFileURLWithPath:@"::cloudPath::"];
    self.cloudStoreOptions = @{@"::option::": @"::cloud::"};
    self.fetchCloudStatus = OCMClassMock([FMIFetchCloudStatus class]);
    self.subject = [[FMIStoreConfiguration alloc] initWithManagedObjectModelURL:managedObjectModelURL fetchCloudStatus:self.fetchCloudStatus localStoreURL:self.localStoreURL localStoreOptions:self.localStoreOptions cloudStoreURL:self.cloudStoreURL cloudStoreOptions:self.cloudStoreOptions];
}

- (void)testItReturnsTheCurrentLocalStoreURL {
    OCMStub([self.fetchCloudStatus fetchCloudStatus]).andReturn(FMICloudStatusDisabled);

    NSURL *storeURL = self.subject.currentStoreURL;

    XCTAssertEqualObjects(self.localStoreURL, storeURL);
}

- (void)testItReturnsTheCurrentCloudStoreURL {
    OCMStub([self.fetchCloudStatus fetchCloudStatus]).andReturn(FMICloudStatusEnabled);

    NSURL *storeURL = self.subject.currentStoreURL;

    XCTAssertEqualObjects(self.cloudStoreURL, storeURL);
}

- (void)testItReturnsTheCurrentLocalStoreOptions {
    OCMStub([self.fetchCloudStatus fetchCloudStatus]).andReturn(FMICloudStatusDisabled);

    NSDictionary *storeOptions = self.subject.currentStoreOptions;

    XCTAssertEqualObjects(self.localStoreOptions, storeOptions);
}

- (void)testItReturnsTheCurrentCloudStoreOptions {
    OCMStub([self.fetchCloudStatus fetchCloudStatus]).andReturn(FMICloudStatusEnabled);

    NSDictionary *storeOptions = self.subject.currentStoreOptions;

    XCTAssertEqualObjects(self.cloudStoreOptions, storeOptions);
}

@end
