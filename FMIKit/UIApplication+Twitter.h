//
//  UIApplication+Twitter.h
//
//  Created by Florian Mielke on 17.02.14.
//  Copyright (c) 2014 madeFM. All rights reserved.
//

@import UIKit;

/**
 * Adds methods to UIApplication to handle twitter requests.
 */
@interface UIApplication (Twitter)

/**
 * Opens a given user name in an installed twitter app. Opens browser as fallback.
 * @param twitterUserName The user name to open.
 */
- (void)fm_openTwitterAppWithUserName:(NSString *)twitterUserName;

@end
