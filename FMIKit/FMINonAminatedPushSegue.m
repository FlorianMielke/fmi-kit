//
//  FMINonAminatedPushSegue.m
//  WorkTimes
//
//  Created by Florian Mielke on 24.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMINonAminatedPushSegue.h"


@implementation FMINonAminatedPushSegue


- (void)perform
{
    UIViewController *sourceController = self.sourceViewController;
    [sourceController.navigationController pushViewController:self.destinationViewController animated:NO];
}


@end
