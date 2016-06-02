#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FMICloudStatus) {
    FMICloudStatusUnknown = 0,
    FMICloudStatusEnabled,
    FMICloudStatusDisabled,
    FMICloudStatusChanging,
};
