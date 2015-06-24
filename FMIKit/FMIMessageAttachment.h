//
//  FMIMessageAttachment.h
//
//  Created by Florian on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * An instance of the FMIMessageAttachment class represenct an attachment for a mail message.
 */
@interface FMIMessageAttachment : NSObject

/**
 * The attehment data.
 */
@property (readonly, NS_NONATOMIC_IOSONLY) NSData *data;

/**
 * The file name.
 */
@property (copy, readonly, NS_NONATOMIC_IOSONLY) NSString *fileName;

/**
 * The MIME type.
 */
@property (copy, readonly, NS_NONATOMIC_IOSONLY) NSString *mimeType;

/**
 * Returns a new FMIMessageAttachment instance with the given parameter.
 * @param data The attachment data.
 * @param mimeType The MIME type.
 * @param fileName The file name.
 * @note If one of the parameter is nil returns nil.
 */
+ (instancetype)messageAttachmentForData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName;

@end
