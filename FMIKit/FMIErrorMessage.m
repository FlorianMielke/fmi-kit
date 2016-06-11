#import "FMIErrorMessage.h"
#import "FMIAttachment.h"
#import "NSBundle+FMIAppInfo.h"
#import "UIDevice+Platform.h"

@interface FMIErrorMessage ()

@property (NS_NONATOMIC_IOSONLY) NSBundle *bundle;
@property (NS_NONATOMIC_IOSONLY) id <FMIAttachment> logFile;

@end

@implementation FMIErrorMessage

- (instancetype)initWithLogFile:(id <FMIAttachment>)logFile bundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        self.bundle = bundle ?: [NSBundle mainBundle];
        self.logFile = logFile;
    }
    return self;
}

- (NSArray *)toRecipients {
    return @[@"feedback@systemweit.de"];
}

- (NSString *)subject {
    return [NSString stringWithFormat:@"%@ %@ Log Files", self.bundle.fmi_appName, self.bundle.fmi_presentableVersionNumber];
}

- (NSString *)messageBody {
    NSMutableString *messageBody = [NSMutableString stringWithFormat:@"\n\n-------------------------\n"];
    [messageBody appendFormat:@"iOS Version: %@\n", [UIDevice currentDevice].systemVersion];
    [messageBody appendFormat:@"iOS Device: %@\n", [UIDevice currentDevice].platform];
    [messageBody appendFormat:@"System language: %@\n", [NSLocale preferredLanguages].firstObject];
    return [messageBody copy];
}

- (NSArray *)attachments {
    return @[self.logFile];
}

@end
