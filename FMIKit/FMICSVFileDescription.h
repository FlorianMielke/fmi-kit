//
//  FMICSVFileDescription.h
//
//  Created by Florian Mielke on 02.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;


/**
 * Descripes a file like CSV.
 */
@interface FMICSVFileDescription : NSObject

/**
 * The delimiter. The default is , (comma).
 */
@property (nonatomic, strong) NSString *delimiter;

/**
 * The encloser. The default is " (apostrophe).
 */
@property (nonatomic, strong) NSString *encloser;

/**
 * The string encoding. The default is NSUTF8StringEncoding
 */
@property (nonatomic, assign) NSStringEncoding encoding;

/**
 * Returns an array containing the field descriptions.
 * @note The elements in the array are instances of NSAttributeDescription.
 */
@property (nonatomic, strong) NSArray *fieldDescriptions;

/**
 * The line break. The default ist CRLF.
 */
@property (nonatomic, strong) NSString *lineBreak;

/**
 * A Boolean that indicate whether to skip the first line. The default is YES.
 */
@property (nonatomic, assign) BOOL skipFirstLine;

@end
