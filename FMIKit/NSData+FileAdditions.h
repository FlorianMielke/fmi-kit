//
//  NSData+FileAdditions.h
//
//  Created by Florian on 08.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;

/**
 * This category add methods to NSData to improve file operations
 */
@interface NSData (FileAdditions)

/**
 * Writes data to the temporary dictionary
 * @param fileName The file name to use
 * @param extension If extension is an empty string or nil, the extension is assumed not to exist and the file is the first file encountered that exactly matches name
 * @return NSURL The url the data is written to
 */
- (NSURL *)writeToTemporaryDictionaryUsingFileName:(NSString *)fileName type:(NSString *)extension;

@end
