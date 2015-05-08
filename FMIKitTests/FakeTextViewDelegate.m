//
//  Created by Florian Mielke on 28.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FakeTextViewDelegate.h"
#import "FMINumericTextView.h"


@implementation FakeTextViewDelegate


- (NSArray *)compoundTextViewsForTextView:(FMINumericTextView *)textView
{
    return [self compoundTextViews];
}


@end
