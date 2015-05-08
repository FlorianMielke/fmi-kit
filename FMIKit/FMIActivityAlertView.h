//
//  FMIActivityAlertView.h
//
//  Created by Florian Mielke on 28.03.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import UIKit;


/**
 * An alert view subclass containing a title and an activity indicator
 */
@interface FMIActivityAlertView : UIAlertView

/**
 * The alert view's activitiy indicator view
 */
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicatorView;

/**
 *	Convenience method for initializing the activity alert view.
 *	@param	title       The string that appears in the receiver’s title bar.
 *	@param	delegate    The receiver’s delegate or nil if it doesn’t have a delegate.
 *	@return	Newly initialized activity alert view.
 */
- (id)initWithTitle:(NSString *)title delegate:(id)delegate;

@end
