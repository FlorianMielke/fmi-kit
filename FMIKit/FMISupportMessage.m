//
//  FMISupportMessage.m
//
//  Created by Florian Mielke on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMISupportMessage.h"
#import "UIDevice+Platform.h"


@interface FMISupportMessage ()

@property (nonatomic, strong) NSBundle *bundle;

@end


@implementation FMISupportMessage


#pragma mark - Initialization

- (id)initWithBundle:(NSBundle *)bundle
{
    self = [super init];
    
    if (self != nil)
    {
        _bundle = (bundle != nil) ? bundle : [NSBundle mainBundle];
    }
    
    return self;
}


- (id)init
{
    return [self initWithBundle:[NSBundle mainBundle]];
}


- (NSArray *)toRecipients
{
    return @[@"support@madefm.com"];
}


- (NSString *)subject
{
    NSString *nameOfApp = [[[self bundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString *versionOfAppRange = [[[self bundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *buildVersionOfApp = [[[self bundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    return [NSString stringWithFormat:@"%@ %@ (%@) Feedback", nameOfApp, versionOfAppRange, buildVersionOfApp];
}


- (NSString *)messageBody
{
    NSMutableString *messageBody = [NSMutableString stringWithFormat:@"\n\n-------------------------\n"];
    [messageBody appendFormat:@"iOS Version: %@\n", [[UIDevice currentDevice] systemVersion]];
    [messageBody appendFormat:@"iOS Device: %@\n", [[UIDevice currentDevice] platform]];
    [messageBody appendFormat:@"System language: %@\n", [[NSLocale preferredLanguages] firstObject]];

    return [messageBody copy];
}

@end
