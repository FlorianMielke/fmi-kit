#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMIModifyCloudStatus.h"
#import "FMICloudStatusGateway.h"
#import "FMIStore.h"

@interface FMIModifyCloudStatusTest : XCTestCase

@property (NS_NONATOMIC_IOSONLY) FMIModifyCloudStatus *subject;
@property (NS_NONATOMIC_IOSONLY) id gateway;

@end

@implementation FMIModifyCloudStatusTest

- (void)setUp {
    [super setUp];
    self.gateway = OCMProtocolMock(@protocol(FMICloudStatusGateway));
    self.subject = [[FMIModifyCloudStatus alloc] initWithCloudStatusGateway:self.gateway];
}

- (void)testItModifiesCloudStatusToEnabled {
    OCMStub([self.gateway fetchCloudStatus]).andReturn(FMICloudStatusUnknown);

    [self.subject modifyCloudStatus:FMICloudStatusEnabled];

    OCMVerify([self.gateway saveCloudStatus:FMICloudStatusEnabled]);
}

- (void)testItModifiesCloudStatusToDisabled {
    [self.subject modifyCloudStatus:FMICloudStatusDisabled];

    OCMVerify([self.gateway saveCloudStatus:FMICloudStatusDisabled]);
}

@end
