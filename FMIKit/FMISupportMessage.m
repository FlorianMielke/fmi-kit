#import "FMISupportMessage.h"
#import "UIDevice+Platform.h"
#import "NSBundle+FMIAppInfo.h"

@interface FMISupportMessage ()

@property (NS_NONATOMIC_IOSONLY) NSBundle *bundle;
@property (NS_NONATOMIC_IOSONLY) NSString *emailAddress;

@end

@implementation FMISupportMessage

- (instancetype)init {
  return [self initWithBundle:[NSBundle mainBundle] emailAddress:@"feedback@systemweit.de"];
}

- (instancetype)initWithBundle:(NSBundle *)bundle {
  return [self initWithBundle:bundle emailAddress:@"feedback@systemweit.de"];
}

- (instancetype)initWithBundle:(NSBundle *)bundle emailAddress:(NSString *)emailAddress {
  self = [super init];
  if (self) {
    self.bundle = bundle ?: [NSBundle mainBundle];
    self.emailAddress = emailAddress;
  }
  return self;
}

- (NSArray *)toRecipients {
  return @[self.emailAddress];
}

- (NSString *)subject {
  return [NSString stringWithFormat:@"%@ %@ Feedback", self.bundle.fmi_appName, self.bundle.fmi_presentableVersionNumber];
}

- (NSString *)messageBody {
  NSMutableString *messageBody = [NSMutableString stringWithFormat:@"\n\n-------------------------\n"];
  [messageBody appendFormat:@"iOS Version: %@\n", [UIDevice currentDevice].systemVersion];
  [messageBody appendFormat:@"iOS Device: %@\n", [UIDevice currentDevice].platform];
  [messageBody appendFormat:@"System language: %@\n", [NSLocale preferredLanguages].firstObject];
  return [messageBody copy];
}

- (NSArray *)attachments {
  return @[];
}

@end
