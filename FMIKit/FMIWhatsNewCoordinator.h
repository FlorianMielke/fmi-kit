#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIWhatsNewCoordinator : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) BOOL shouldShow;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *localizedWhatsNewURL;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithBundle:(NSBundle *)bundle userDefaults:(NSUserDefaults *)userDefaults whatsNewBaseURL:(NSURL *)whatsNewBaseURL;

- (void)viewed;

@end

NS_ASSUME_NONNULL_END