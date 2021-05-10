#import "FMIErrorLogFile.h"
#import "NSBundle+FMIAppInfo.h"
#import <FMIKit/FMIKit-Swift.h>

NSString *const FMIErrorLogFileExtension = @"log";

@interface FMIErrorLogFile ()

@property (copy, NS_NONATOMIC_IOSONLY) NSError *error;
@property (nullable, copy, NS_NONATOMIC_IOSONLY) NSString *diagnosticData;
@property (NS_NONATOMIC_IOSONLY) NSBundle *bundle;

@end

@implementation FMIErrorLogFile

- (instancetype)initWithError:(NSError *)error diagnosticData:(nullable NSString *)diagnosticData bundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        self.error = error;
        self.diagnosticData = diagnosticData;
        self.bundle = bundle;
    }
    return self;
}

- (NSString *)fileName {
    return [self.bundle.fmi_appName stringByAppendingFormat:@" %@.%@", [NSDate date], FMIErrorLogFileExtension];
}

- (NSString *)mimeType {
    return [@"text/plain" copy];
}

- (NSData *)dataRepresentation {
    NSMutableString *logFileMessage = [[NSMutableString alloc] initWithString:self.error.logFiled];
    
    if (self.diagnosticData != nil) {
        [logFileMessage appendFormat:@"\n\n%@", self.diagnosticData];
    }
    
    return [logFileMessage dataUsingEncoding:NSUTF8StringEncoding];
}

@end
