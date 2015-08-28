//
//  Created by Florian Mielke on 19.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "MFMailComposeViewController+AlertView.h"
#import "FMIKitPrivates.h"

@implementation MFMailComposeViewController (AlertView)


+ (UIAlertView *)cannotSendMailAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"Cannot Send Mail", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for alert title")
                                                    message:NSLocalizedStringFromTableInBundle(@"Configure a mail account in your Settings to send mail.", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for alert message")
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"OK", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for word")
                                          otherButtonTitles:nil];
    return alert;
}


+ (UIAlertView *)sendingMailFailedAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"Sending Mail Failed", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for alert title")
                                                    message:NSLocalizedStringFromTableInBundle(@"Please check your email settings and internet connection.", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for alert message")
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"OK", @"FMIKitLocalizable", [FMIKitPrivates resourcesBundle], @"Used for word")
                                          otherButtonTitles:nil];
    return alert;
}


@end
