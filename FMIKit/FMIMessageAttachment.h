//
//  FMIMessageAttachment.h
//
//  Created by Florian on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;


/**
 * An instance of the FMIMessageAttachment class represenct an attachment for a mail message.
 */
@interface FMIMessageAttachment : NSObject

/**
 * The attehment data.
 */
@property (nonatomic, strong, readonly) NSData *data;

/**
 * The file name.
 */
@property (nonatomic, copy, readonly) NSString *fileName;

/**
 * The MIME type.
 */
@property (nonatomic, copy, readonly) NSString *mimeType;

/**
 * Returns a new FMIMessageAttachment instance with the given parameter.
 * @param data The attachment data.
 * @param mimeType The MIME type.
 * @param fileName The file name.
 * @note If one of the parameter is nil returns nil.
 */
+ (id)messageAttachmentForData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName;

@end
