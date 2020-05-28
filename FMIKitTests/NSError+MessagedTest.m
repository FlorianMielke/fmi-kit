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
    
    XCTAssertEqualObjects(@"Failure Reason.\n\nRecovery Suggestion.", subject.messaged);
}

- (void)testFullMessaged {
    NSError *underlyingError = [NSError errorWithDomain:@"::domain::" code:45 userInfo:@{
        NSLocalizedDescriptionKey: @"Underlying Description.",
        NSLocalizedFailureReasonErrorKey: @"Underlying Failure Reason.",
        NSLocalizedRecoverySuggestionErrorKey: @"Underlying Recovery Suggestion.",
    }];
    
    NSError *subject = [NSError errorWithDomain:@"::domain::" code:-1 userInfo:@{
        NSLocalizedDescriptionKey: @"Description.",
        NSLocalizedFailureReasonErrorKey: @"Failure Reason.",
        NSLocalizedRecoverySuggestionErrorKey: @"Recovery Suggestion.",
        NSUnderlyingErrorKey: underlyingError
    }];
    
    XCTAssertEqualObjects(@"Failure Reason.\n\nRecovery Suggestion.\n\nUnderlying Description. Underlying Failure Reason. Underlying Recovery Suggestion.", subject.messaged);
}

@end
