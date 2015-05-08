//
//  FMIActivityAlertView.m
//
//  Created by Florian Mielke on 28.03.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIActivityAlertView.h"


@interface FMIActivityAlertView ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end



@implementation FMIActivityAlertView


#pragma mark -
#pragma mark View lifecycle

- (id)initWithTitle:(NSString *)title delegate:(id)delegate
{
    self = [super initWithTitle:title message:nil delegate:delegate cancelButtonTitle:nil otherButtonTitles:nil];
    
    if (self) {
        [self addSubview:[self activityIndicatorView]];
    }
    
    return self;
}


- (void)show
{
    [[self activityIndicatorView] startAnimating];
    
    [super show];
}



#pragma mark -
#pragma mark Activity indicator

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (_activityIndicatorView) {
        return _activityIndicatorView;
    }
        
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_activityIndicatorView setFrame:CGRectMake(125.0, 50.0, 30.0, 30.0)];

    return _activityIndicatorView;
}


@end
