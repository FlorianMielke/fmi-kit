#import <Foundation/Foundation.h>
#import "NSBundle+FMIKit.h"

#define FMILocalizedStringForKey(key) [[NSBundle fmiKitBundle] localizedStringForKey:(key) value:@"" table:@"FMIKitLocalizable"]
