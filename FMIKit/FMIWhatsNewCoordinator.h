#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMIWhatsNewCoordinator : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) BOOL shouldShow;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithBundle:(NSBundle *)bundle userDefaults:(NSUserDefaults *)userDefaults;

- (void)viewed;

@end

NS_ASSUME_NONNULL_END