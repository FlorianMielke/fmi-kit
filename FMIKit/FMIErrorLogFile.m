#import "FMIErrorLogFile.h"
#import "NSBundle+FMIAppInfo.h"
#import <FMIKit/FMIKit-Swift.h>

NSString *const FMIErrorLogFileExtension = @"log";

@interface FMIErrorLogFile ()

@property (copy, NS_NONATOMIC_IOSONLY) NSError *error;
@property (NS_NONATOMIC_IOSONLY) NSBundle *bundle;

@end

@implementation FMIErrorLogFile

- (instancetype)initWithError:(NSError *)error bundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        self.error = error;
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
    return [self.error.completeMessaged dataUsingEncoding:NSUTF8StringEncoding];
}

@end
