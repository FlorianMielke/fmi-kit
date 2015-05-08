//
//  FMISupportMessage.h
//
//  Created by Florian Mielke on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;
#import "FMIMessage.h"


/**
 *  The FMISupportMessage class composes the support message texts.
 */
@interface FMISupportMessage : NSObject <FMMessage>

/**
 *  Returns the support message message body.
 */
- (NSString *)messageBody;

/**
 *  Returns the support message subject.
 */
- (NSString *)subject;

/**
 *  Returns an NSArray containing all support recipients.
 */
- (NSArray *)toRecipients;

/**
 *	Creates a new support message.
 *	@param	bundle	The bundle to grab the app information from. If bundle is nil, mainBundle will be assigned.
 *	@return	A new support message object.
 */
- (id)initWithBundle:(NSBundle *)bundle;

@end
