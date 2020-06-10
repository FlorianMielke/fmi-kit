@import XCTest;
#import <FMIKit/FMIKit-Swift.h>

@interface NSError_MessagedTest : XCTestCase

@end

@implementation NSError_MessagedTest

- (void)testMessaged {
    NSError *subject = [NSError errorWithDomain:@"::domain::" code:-1 userInfo:@{
        NSLocalizedDescriptionKey: @"Description.",
        NSLocalizedFailureReasonErrorKey: @"Failure Reason.",
        NSLocalizedRecoverySuggestionErrorKey: @"Recovery Suggestion.",
    }];
    
    XCTAssertEqualObjects(@"Failure Reason.\n\nRecovery Suggestion.", subject.completeMessaged);
}

@end
