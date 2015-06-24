//
//  NSString+FileName.h
//
//  Created by Florian Mielke on 08.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;

/**
 * This category adds methods to NSString to improve support for file and url operations
 */
@interface NSString (FileName)

/**
 * Removes any invalid characters that are usually not accepted by Operating Systems
 * and trims the name to 60 characters
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *validFileName;

/**
 * Encodes a string to be used in an url
 * @param str The value that needs to be encoded
 * @return NSString The encoded str
 */
+ (NSString *)urlEncodeValue:(NSString *)str;

/**
 * Removes any invalid characters that are usually not accepted by Operating Systems with or without an extension
 * If extension is an empty string or nil, the extension is assumed not to exist and the file name returned exactly matches name.
 * @param extension File extension.
 * @return NSString The valid file name
 */
- (NSString *)validFileNameWithType:(NSString *)extension;

/**
 * Returns a unique file name of the receiver based on a list of file names.
 * @param fileNames An array of file names to validate.
 * @return NSString A unique file name having a recurring number as suffix in the case of duplicated file names. Returns the receiver if no duplicates where found.
 */
- (NSString *)uniqueFileNameInFileNames:(NSArray *)fileNames;

@end
