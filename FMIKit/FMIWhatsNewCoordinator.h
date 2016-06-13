#import <Foundation/Foundation.h>

@protocol FMIURLProvider;

NS_ASSUME_NONNULL_BEGIN

@interface FMIWhatsNewCoordinator : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) BOOL shouldShow;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *localizedWhatsNewURL;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithBundle:(NSBundle *)bundle userDefaults:(NSUserDefaults *)userDefaults URLProvider:(id <FMIURLProvider>)URLProvider;

- (void)viewed;

@end

NS_ASSUME_NONNULL_END