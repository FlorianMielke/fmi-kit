@import XCTest;
#import <FMIKit/FMIKit-Swift.h>

@interface NSError_MessagedTest : XCTestCase

@end

@implementation NSError_MessagedTest

- (void)testLogFiled {
    NSError *subject = [NSError errorWithDomain:@"::domain::" code:-1 userInfo:@{
        NSLocalizedDescriptionKey: @"Description.",
        NSLocalizedFailureReasonErrorKey: @"Failure Reason.",
        NSLocalizedRecoverySuggestionErrorKey: @"Recovery Suggestion.",
    }];
    
    XCTAssertEqualObjects(@"Description.\n\nFailure Reason.\n\nRecovery Suggestion.", subject.logFiled);
}

@end
