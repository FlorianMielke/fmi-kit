#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "FMILogFile.h"
#import "FMIErrorLogFile.h"

@interface FMIErrorLogFileTest : XCTestCase

@end

@implementation FMIErrorLogFileTest

- (void)testItCanBeArchived {
    id archiver = OCMClassMock([NSKeyedArchiver class]);
    NSError *error = [[NSError alloc] init];
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"App.log"];
    FMIErrorLogFile *subject = [[FMIErrorLogFile alloc] init];

    [subject save];

    OCMVerify([archiver archiveRootObject:error toFile:path]);

    [archiver stopMocking];
}

@end
