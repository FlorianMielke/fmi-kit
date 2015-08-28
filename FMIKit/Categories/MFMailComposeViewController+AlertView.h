//
//  Created by Florian Mielke on 19.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <MessageUI/MessageUI.h>

/**
 * This category adds alert view methods to MFMailComposeViewController.
 */
@interface MFMailComposeViewController (AlertView)

/**
 * Returns an alert view to hint that no mail account is configured.
 */
+ (UIAlertView *)cannotSendMailAlertView;

/**
 * Returns an alert view to hint that sending mail failed.
 */
+ (UIAlertView *)sendingMailFailedAlertView;

@end
