#import "FMIWhatsNewCoordinator.h"
#import "NSLocale+German.h"

NSString *const FMIWhatsNewLastViewedVersionKey = @"FMIWhatsNewLastViewedVersionKey";

@interface FMIWhatsNewCoordinator ()

@property (NS_NONATOMIC_IOSONLY) NSBundle *bundle;
@property (NS_NONATOMIC_IOSONLY) NSUserDefaults *userDefaults;
@property (NS_NONATOMIC_IOSONLY) NSURL *whatsNewBaseURL;

@end

@implementation FMIWhatsNewCoordinator

- (instancetype)initWithBundle:(NSBundle *)bundle userDefaults:(NSUserDefaults *)userDefaults whatsNewBaseURL:(NSURL *)whatsNewBaseURL {
    self = [super init];
    if (self) {
        self.bundle = bundle;
        self.userDefaults = userDefaults;
        self.whatsNewBaseURL = whatsNewBaseURL;
    }
    return self;
}

- (NSURL *)localizedWhatsNewURL {
    if ([NSLocale fmi_isGermanLanguage]) {
        NSString *path = self.whatsNewBaseURL.absoluteString;
        NSString *localizedPath = [path stringByReplacingOccurrencesOfString:@"/en/" withString:@"/de/"];
        return [NSURL URLWithString:localizedPath];
    }
    return self.whatsNewBaseURL;
}

- (BOOL)shouldShow {
    NSString *currentVersion = self.bundle.infoDictionary[@"CFBundleShortVersionString"];
    return (![[self.userDefaults objectForKey:FMIWhatsNewLastViewedVersionKey] isEqualToString:currentVersion]);
}

- (void)viewed {
    NSString *currentVersion = self.bundle.infoDictionary[@"CFBundleShortVersionString"];
    [self.userDefaults setObject:currentVersion forKey:FMIWhatsNewLastViewedVersionKey];
    [self.userDefaults synchronize];
}

@end
