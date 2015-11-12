//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMIBindingManager.h"
#import "FakeBindingModel.h"
#import "FakeBindingObserver.h"

@interface FMIBindingManagerTests : XCTestCase

@property(NS_NONATOMIC_IOSONLY) FMIBindingManager *bindingManager;
@property(NS_NONATOMIC_IOSONLY) FakeBindingObserver *testObserver;
@property(NS_NONATOMIC_IOSONLY) FakeBindingModel *testModel;

@end

@implementation FMIBindingManagerTests

- (void)setUp {
    [super setUp];
    self.bindingManager = [[FMIBindingManager alloc] init];
    self.testObserver = [[FakeBindingObserver alloc] init];
    self.testModel = [[FakeBindingModel alloc] init];
}

- (void)testCopiesValuesOnEnable {
    self.testModel.stringValue = @"Test Value";
    [self.bindingManager bindObserver:self.testObserver keyPath:@"text" toSubject:self.testModel keyPath:@"stringValue"];

    XCTAssertNil(self.testObserver.text);

    [self.bindingManager enable];

    XCTAssertTrue(self.bindingManager.isEnabled);
    XCTAssertEqualObjects(@"Test Value", self.testObserver.text);
}

- (void)testCopiesValuesOnChange {
    self.testModel.stringValue = @"Test Value";
    [self.bindingManager bindObserver:self.testObserver keyPath:@"text" toSubject:self.testModel keyPath:@"stringValue"];

    [self.bindingManager enable];

    self.testModel.stringValue = @"Changed Value";

    XCTAssertEqualObjects(@"Changed Value", self.testObserver.text);

    self.testModel.stringValue = @"Changed Value Again";

    XCTAssertEqualObjects(@"Changed Value Again", self.testObserver.text);
}

- (void)testDoesNotCopyAfterDeactivate {
    self.testModel.stringValue = @"Test Value";
    [self.bindingManager bindObserver:self.testObserver keyPath:@"text" toSubject:self.testModel keyPath:@"stringValue"];

    XCTAssertNil(self.testObserver.text);

    [self.bindingManager enable];
    self.testModel.stringValue = @"First Value";

    XCTAssertEqualObjects(@"First Value", self.testObserver.text);

    [self.bindingManager disable];

    XCTAssertFalse(self.bindingManager.isEnabled);

    self.testModel.stringValue = @"Second Value";

    XCTAssertEqualObjects(@"First Value", self.testObserver.text);

}

- (void)testAddBindingToEnabledBindingManager {
    self.testModel.stringValue = @"Test Value";
    [self.bindingManager enable];

    [self.bindingManager bindObserver:self.testObserver keyPath:@"text" toSubject:self.testModel keyPath:@"stringValue"];

    XCTAssertEqualObjects(@"Test Value", self.testObserver.text);

    self.testModel.stringValue = @"First Value";

    XCTAssertEqualObjects(@"First Value", self.testObserver.text);
}

- (void)testRemoveBindings {
    self.testModel.stringValue = @"Test Value";
    [self.bindingManager bindObserver:self.testObserver keyPath:@"text" toSubject:self.testModel keyPath:@"stringValue"];
    [self.bindingManager enable];
    self.testModel.stringValue = @"Changed Value";
    [self.bindingManager removeAllBindings];
    self.testModel.stringValue = @"Changed Value Again";

    XCTAssertEqualObjects(@"Changed Value", self.testObserver.text);

    XCTAssertTrue(self.bindingManager.isEnabled);

    [self.bindingManager bindObserver:self.testObserver keyPath:@"text" toSubject:self.testModel keyPath:@"stringValue"];

    XCTAssertEqualObjects(@"Changed Value Again", self.testObserver.text);
}

- (void)testMultipleModelProperties {
    self.testModel.stringValue = @"String 1";
    self.testModel.stringValue2 = @"String 2";
    FakeBindingObserver *observer1 = [[FakeBindingObserver alloc] init];
    FakeBindingObserver *observer2 = [[FakeBindingObserver alloc] init];
    [self.bindingManager bindObserver:observer1 keyPath:@"text" toSubject:self.testModel keyPath:@"stringValue"];
    [self.bindingManager bindObserver:observer2 keyPath:@"text" toSubject:self.testModel keyPath:@"stringValue2"];

    [self.bindingManager enable];

    XCTAssertEqualObjects(@"String 1", observer1.text);
    XCTAssertEqualObjects(@"String 2", observer2.text);

    self.testModel.stringValue = @"Changed String 1";
    self.testModel.stringValue2 = @"Changed String 2";

    XCTAssertEqualObjects(@"Changed String 1", observer1.text);
    XCTAssertEqualObjects(@"Changed String 2", observer2.text);
}

- (void)testMultipleModels {
    FakeBindingModel *model1 = [[FakeBindingModel alloc] init];
    model1.stringValue = @"String 1";
    FakeBindingModel *model2 = [[FakeBindingModel alloc] init];
    model2.stringValue = @"String 2";
    FakeBindingObserver *observer1 = [[FakeBindingObserver alloc] init];
    FakeBindingObserver *observer2 = [[FakeBindingObserver alloc] init];
    [self.bindingManager bindObserver:observer1 keyPath:@"text" toSubject:model1 keyPath:@"stringValue"];
    [self.bindingManager bindObserver:observer2 keyPath:@"text" toSubject:model2 keyPath:@"stringValue"];

    [self.bindingManager enable];

    XCTAssertEqualObjects(@"String 1", observer1.text);
    XCTAssertEqualObjects(@"String 2", observer2.text);

    model1.stringValue = @"Changed String 1";
    model2.stringValue = @"Changed String 2";

    XCTAssertEqualObjects(@"Changed String 1", observer1.text);
    XCTAssertEqualObjects(@"Changed String 2", observer2.text);
}

- (void)testValueTransform {
    self.testModel.numericValue = 33;

    [self.bindingManager bindObserver:self.testObserver keyPath:@"text" toSubject:self.testModel keyPath:@"numericValue" withValueTransform:^(id value) {
        return [value stringValue];
    }];

    [self.bindingManager enable];

    XCTAssertEqualObjects(@"33", self.testObserver.text);

    self.testModel.numericValue = 22;
    XCTAssertEqualObjects(@"22", self.testObserver.text);
}

- (void)testSubjectKeyPath {
    FakeBindingModel *topModel = [[FakeBindingModel alloc] init];
    FakeBindingModel *subModel = [[FakeBindingModel alloc] init];

    topModel.submodel = subModel;

    [self.bindingManager bindObserver:self.testObserver keyPath:@"text" toSubject:topModel keyPath:@"submodel.stringValue"];
    [self.bindingManager enable];

    subModel.stringValue = @"Submodel value";

    XCTAssertEqualObjects(@"Submodel value", self.testObserver.text);
}

@end
