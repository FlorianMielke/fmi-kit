//
//  Created by Florian Mielke on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIMessageMIMETypes.h"

@implementation FMIMessageMIMETypes

+ (NSDictionary *)mimeTypes {
    static dispatch_once_t pred = 0;
    __strong static id _mimeTypes = nil;
    dispatch_once(&pred, ^{
    	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"FMIMessageMIMETypes" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        _mimeTypes = [dict valueForKey:@"MIMETypes"];
    });
	return _mimeTypes;
}

+ (NSString *)mimeTypeForFileExtension:(NSString *)fileExtension {
    NSDictionary *mimeTypes = [FMIMessageMIMETypes mimeTypes];
    fileExtension = [fileExtension lowercaseString];
    NSString *mimeType = mimeTypes[fileExtension];
    if (mimeType) {
        return mimeType;
    }
    for (NSString *multipleFileExtensions in [mimeTypes allKeys]) {
        NSArray *fileExtensionComponents = [multipleFileExtensions componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([fileExtensionComponents containsObject:fileExtension]) {
            mimeType = mimeTypes[multipleFileExtensions];
            if (mimeType) {
                break;
            }
        }
    }
    if (!mimeType) {
        mimeType = @"application/octet-stream";
    }
    return mimeType;
}

@end
