#import <Foundation/Foundation.h>

@interface NSBundle (FMIAppInfo)

@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *fmi_appName;
@property (readonly, NS_NONATOMIC_IOSONLY) NSString *fmi_versionNumber;
@property (readonly, NS_NONATOMIC_IOSONLY) NSString *fmi_buildNumber;
@property (readonly, NS_NONATOMIC_IOSONLY) NSString *fmi_presentableVersionNumber;

@end