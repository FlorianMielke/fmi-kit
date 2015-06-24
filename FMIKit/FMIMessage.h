//
//  FMMessage.h
//
//  Created by Florian Mielke on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * An Interface for messages.
 */
@protocol FMMessage <NSObject>

/**
 * Returns the message body.
 */
- (NSString *)messageBody;

/**
 * Returns the message subject.
 */
- (NSString *)subject;

/**
 * Returns an NSArray containing all recipients.
 */
- (NSArray *)toRecipients;

@optional
/**
 * Returns an NSArray containing FMIMessageAttachment items.
 * @see FMIMessageAttachment.
 * @note Optional.
 */
- (NSArray *)attachments;

@end
