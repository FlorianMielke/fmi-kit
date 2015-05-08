//
//  Created by Florian Mielke on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;

@interface FMIMessageMIMETypes : NSObject

/**
 * Returns a NSDictionary with available MIME types where the key contains file extensions and the value the appropriate MIME type.
 */
+ (NSDictionary *)mimeTypes;

/**
 * Returns the MIME type for a given file extension.
 * @param fileExtension The file extension.
 * @return A NSString representing the MIME type, 'application/octet-stream' if MIME type was not found.
 */
+ (NSString *)mimeTypeForFileExtension:(NSString *)fileExtension;

@end
