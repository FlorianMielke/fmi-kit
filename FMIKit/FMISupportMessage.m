//
//  FMISupportMessage.m
//
//  Created by Florian Mielke on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMISupportMessage.h"
#import "UIDevice+Platform.h"
#import "NSBundle+FMIAppInfo.h"

@interface FMISupportMessage ()

@property (NS_NONATOMIC_IOSONLY) NSBundle *bundle;

@end

@implementation FMISupportMessage

- (instancetype)init {
    return [self initWithBundle:[NSBundle mainBundle]];
}

- (instancetype)initWithBundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        _bundle = bundle ?: [NSBundle mainBundle];
    }
    return self;
}

- (NSArray *)toRecipients {
    return @[@"feedback@systemweit.de"];
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
