//
//  UIApplication+Twitter.m
//
//  Created by Florian Mielke on 17.02.14.
//  Copyright (c) 2014 madeFM. All rights reserved.
//

#import "UIApplication+Twitter.h"

@implementation UIApplication (Twitter)


- (void)fm_openTwitterAppWithUserName:(NSString *)twitterUserName
{
	UIApplication *app = [UIApplication sharedApplication];
    
	// Twitter:
	NSURL *twitterURL = [NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@", twitterUserName]];
	if ([app canOpenURL:twitterURL])
	{
		[app openURL:twitterURL];
		return;
	}
	
    // Tweetbot: http://tapbots.com/blog/development/tweetbot-url-scheme
	NSURL *tweetbotURL = [NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///user_profile/%@", twitterUserName]];
	if ([app canOpenURL:tweetbotURL])
	{
		[app openURL:tweetbotURL];
		return;
	}
    
	// Birdfeed: http://birdfeed.tumblr.com/post/172994970/url-scheme
	NSURL *birdfeedURL = [NSURL URLWithString:[NSString stringWithFormat:@"x-birdfeed://user?screen_name=%@", twitterUserName]];
	if ([app canOpenURL:birdfeedURL])
	{
		[app openURL:birdfeedURL];
		return;
	}
	
	// Twittelator: http://www.stone.com/Twittelator/Twittelator_API.html
	NSURL *twittelatorURL = [NSURL URLWithString:[NSString stringWithFormat:@"twit:///user?screen_name=%@", twitterUserName]];
	if ([app canOpenURL:twittelatorURL])
	{
		[app openURL:twittelatorURL];
		return;
	}
	
	// Icebird: http://icebirdapp.com/developerdocumentation/
	NSURL *icebirdURL = [NSURL URLWithString:[NSString stringWithFormat:@"icebird://user?screen_name=%@", twitterUserName]];
	if ([app canOpenURL:icebirdURL])
	{
		[app openURL:icebirdURL];
		return;
	}
	
	// Fluttr: no docs
	NSURL *fluttrURL = [NSURL URLWithString:[NSString stringWithFormat:@"fluttr://user/%@", twitterUserName]];
	if ([app canOpenURL:fluttrURL])
	{
		[app openURL:fluttrURL];
		return;
	}
	
	// SimplyTweet: http://motionobj.com/blog/url-schemes-in-simplytweet-23
	NSURL *simplytweetURL = [NSURL URLWithString:[NSString stringWithFormat:@"simplytweet:?link=http://twitter.com/%@", twitterUserName]];
	if ([app canOpenURL:simplytweetURL])
	{
		[app openURL:simplytweetURL];
		return;
	}
	
	// Tweetings: http://tweetings.net/iphone/scheme.html
	NSURL *tweetingsURL = [NSURL URLWithString:[NSString stringWithFormat:@"tweetings:///user?screen_name=%@", twitterUserName]];
	if ([app canOpenURL:tweetingsURL])
	{
		[app openURL:tweetingsURL];
		return;
	}
	
	// Echofon: http://echofon.com/twitter/iphone/guide.html
	NSURL *echofonURL = [NSURL URLWithString:[NSString stringWithFormat:@"echofon:///user_timeline?%@", twitterUserName]];
	if ([app canOpenURL:echofonURL])
	{
		[app openURL:echofonURL];
		return;
	}
    
	// --- Fallback: Mobile Twitter in Safari
	NSURL *safariURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://mobile.twitter.com/%@", twitterUserName]];
	
	[app openURL:safariURL];
}

@end
