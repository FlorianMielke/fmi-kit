//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import XCTest;
#import "FMIBindingManager.h"
#import "FakeBindingModel.h"
#import "FakeBindingObserver.h"


@interface FMIBindingManagerTests : XCTestCase

@property (nonatomic, strong) FMIBindingManager *bindingManager;
@property (nonatomic, strong) FakeBindingObserver *testObserver;
@property (nonatomic, strong) FakeBindingModel *testModel;

@end



@implementation FMIBindingManagerTests


#pragma mark - Fixture

- (void)setUp
{
    [super setUp];
    
    _bindingManager = [[FMIBindingManager alloc] init];
    _testObserver = [[FakeBindingObserver alloc] init];
    _testModel = [[FakeBindingModel alloc] init];
}


- (void)tearDown
{
    [_bindingManager disable];
    
    _bindingManager = nil;
    _testObserver = nil;
    _testModel = nil;
    
    [super tearDown];
}


#pragma mark - Binding

- (void)testCopiesValuesOnEnable
{
    // Given
    _testModel.stringValue = @"Test Value";
    
    // When
    [_bindingManager bindObserver:_testObserver keyPath:@"text" toSubject:_testModel keyPath:@"stringValue"];
    
    // Then
    XCTAssertNil(_testObserver.text, @"Value should not change until activation");
    
    [_bindingManager enable];
    
    XCTAssertTrue([_bindingManager isEnabled]);
    XCTAssertEqualObjects(@"Test Value", _testObserver.text, @"Value should have been copied from model to observer");
}


- (void)testCopiesValuesOnChange
{
    _testModel.stringValue = @"Test Value";
    
    [_bindingManager bindObserver:_testObserver keyPath:@"text" toSubject:_testModel keyPath:@"stringValue"];
    
    [_bindingManager enable];
    
    _testModel.stringValue = @"Changed Value";
    
    XCTAssertEqualObjects(@"Changed Value", _testObserver.text, @"New value should have been copied from model to observer");
    
    _testModel.stringValue = @"Changed Value Again";
    
    XCTAssertEqualObjects(@"Changed Value Again", _testObserver.text, @"Newer value should have been copied from model to observer");
}


- (void)testDoesNotCopyAfterDeactivate
{
    _testModel.stringValue = @"Test Value";
    
    [_bindingManager bindObserver:_testObserver keyPath:@"text" toSubject:_testModel keyPath:@"stringValue"];
    
    XCTAssertNil(_testObserver.text, @"Value should not change until activation");
    
    [_bindingManager enable];
    
    _testModel.stringValue = @"First Value";
    
    XCTAssertEqualObjects(@"First Value", _testObserver.text, @"New value should have been copied from model to observer");
    
    [_bindingManager disable];
    
    XCTAssertFalse([_bindingManager isEnabled]);
    
    _testModel.stringValue = @"Second Value";
    
    XCTAssertEqualObjects(@"First Value", _testObserver.text, @"Value should not have been copied after -deactivateBindings");
    
}


- (void)testAddBindingToEnabledBindingManager
{
    _testModel.stringValue = @"Test Value";
    
    [_bindingManager enable];
    
    [_bindingManager bindObserver:_testObserver keyPath:@"text" toSubject:_testModel keyPath:@"stringValue"];
    
    XCTAssertEqualObjects(@"Test Value", _testObserver.text, @"Value should change immediately");
    
    _testModel.stringValue = @"First Value";
    
    XCTAssertEqualObjects(@"First Value", _testObserver.text, @"New value should have been copied from model to observer");
}


- (void)testRemoveBindings
{
    _testModel.stringValue = @"Test Value";
    
    [_bindingManager bindObserver:_testObserver keyPath:@"text" toSubject:_testModel keyPath:@"stringValue"];
    
    [_bindingManager enable];
    
    _testModel.stringValue = @"Changed Value";

    [_bindingManager removeAllBindings];
    
    _testModel.stringValue = @"Changed Value Again";
    
    XCTAssertEqualObjects(@"Changed Value", _testObserver.text, @"Newer value should not have been copied after bindings removed");
    
    XCTAssertTrue([_bindingManager isEnabled], @"Should still be enabled");
    
    [_bindingManager bindObserver:_testObserver keyPath:@"text" toSubject:_testModel keyPath:@"stringValue"];
    
    XCTAssertEqualObjects(@"Changed Value Again", _testObserver.text, @"Newer value should have been copied after re-bind");
}


- (void)testMultipleModelProperties
{
    _testModel.stringValue = @"String 1";
    _testModel.stringValue2 = @"String 2";
    
    FakeBindingObserver *observer1 = [[FakeBindingObserver alloc] init];
    FakeBindingObserver *observer2 = [[FakeBindingObserver alloc] init];
    
    [_bindingManager bindObserver:observer1 keyPath:@"text" toSubject:_testModel keyPath:@"stringValue"];
    [_bindingManager bindObserver:observer2 keyPath:@"text" toSubject:_testModel keyPath:@"stringValue2"];
    
    [_bindingManager enable];
    
    XCTAssertEqualObjects(@"String 1", observer1.text);
    XCTAssertEqualObjects(@"String 2", observer2.text);
    
    _testModel.stringValue = @"Changed String 1";
    _testModel.stringValue2 = @"Changed String 2";
    
    XCTAssertEqualObjects(@"Changed String 1", observer1.text);
    XCTAssertEqualObjects(@"Changed String 2", observer2.text);
}


- (void)testMultipleModels
{
    FakeBindingModel *model1 = [[FakeBindingModel alloc] init];
    model1.stringValue = @"String 1";
    
    FakeBindingModel *model2 = [[FakeBindingModel alloc] init];
    model2.stringValue = @"String 2";
    
    FakeBindingObserver *observer1 = [[FakeBindingObserver alloc] init];
    FakeBindingObserver *observer2 = [[FakeBindingObserver alloc] init];
    
    [_bindingManager bindObserver:observer1 keyPath:@"text" toSubject:model1 keyPath:@"stringValue"];
    [_bindingManager bindObserver:observer2 keyPath:@"text" toSubject:model2 keyPath:@"stringValue"];
    
    [_bindingManager enable];
    
    XCTAssertEqualObjects(@"String 1", observer1.text);
    XCTAssertEqualObjects(@"String 2", observer2.text);
    
    model1.stringValue = @"Changed String 1";
    model2.stringValue = @"Changed String 2";
    
    XCTAssertEqualObjects(@"Changed String 1", observer1.text);
    XCTAssertEqualObjects(@"Changed String 2", observer2.text);    
}


- (void)testValueTransform
{
    _testModel.numericValue = 33;
    
    [_bindingManager bindObserver:_testObserver 
                          keyPath:@"text"
                        toSubject:_testModel
                          keyPath:@"numericValue"
               withValueTransform:^(id value) {
                   return [value stringValue];
               }];
    
    [_bindingManager enable];
    
    XCTAssertEqualObjects(@"33", _testObserver.text);
    
    _testModel.numericValue = 22;
    XCTAssertEqualObjects(@"22", _testObserver.text);
}


- (void)testSubjectKeyPath
{
    FakeBindingModel *topModel = [[FakeBindingModel alloc] init];
    FakeBindingModel *subModel = [[FakeBindingModel alloc] init];
    
    topModel.submodel = subModel;
    
    // Bind to topModel, but use a key path to actually bind to its submodel's stringValue
    [_bindingManager bindObserver:_testObserver keyPath:@"text" toSubject:topModel keyPath:@"submodel.stringValue"];
    [_bindingManager enable];
    
    subModel.stringValue = @"Submodel value";
    
    XCTAssertEqualObjects(@"Submodel value", _testObserver.text);
}

@end
