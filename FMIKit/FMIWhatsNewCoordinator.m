#import "FMIWhatsNewCoordinator.h"
#import "FMIURLProvider.h"

NSString *const FMIWhatsNewLastViewedVersionKey = @"FMIWhatsNewLastViewedVersionKey";

@interface FMIWhatsNewCoordinator ()

@property (NS_NONATOMIC_IOSONLY) NSBundle *bundle;
@property (NS_NONATOMIC_IOSONLY) NSUserDefaults *userDefaults;
@property (NS_NONATOMIC_IOSONLY) id <FMIURLProvider> URLProvider;

@end

@implementation FMIWhatsNewCoordinator

- (instancetype)initWithBundle:(NSBundle *)bundle userDefaults:(NSUserDefaults *)userDefaults URLProvider:(id <FMIURLProvider>)URLProvider {
    self = [super init];
    if (self) {
        self.bundle = bundle;
        self.userDefaults = userDefaults;
        self.URLProvider = URLProvider;
    }
    return self;
}

- (NSURL *)localizedWhatsNewURL {
    return [self.URLProvider provideURL];
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
