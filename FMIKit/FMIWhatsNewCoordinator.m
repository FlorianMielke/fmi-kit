#import "FMIWhatsNewCoordinator.h"

NSString *const FMIWhatsNewLastViewedVersionKey = @"FMIWhatsNewLastViewedVersionKey";

@interface FMIWhatsNewCoordinator ()

@property (NS_NONATOMIC_IOSONLY) NSBundle *bundle;
@property (NS_NONATOMIC_IOSONLY) NSUserDefaults *userDefaults;

@end

@implementation FMIWhatsNewCoordinator

- (instancetype)initWithBundle:(NSBundle *)bundle userDefaults:(NSUserDefaults *)userDefaults {
    self = [super init];
    if (self) {
        self.bundle = bundle;
        self.userDefaults = userDefaults;
    }
    return self;
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
