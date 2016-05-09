//
//  Created by Florian Mielke on 16.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSLocale+German.h"

@implementation NSLocale (German)

+ (BOOL)fmi_isGermanLanguage {
    NSString *preferredLanguage = [NSLocale preferredLanguages].firstObject;
    return [preferredLanguage hasPrefix:@"de-"];
}

@end
