//
//  Created by Florian Mielke on 28.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;
#import "FMINumericTextView.h"


@interface FakeTextViewDelegate : NSObject  <FMINumericTextViewDelegate>

@property (nonatomic, strong) NSArray *compoundTextViews;

@end
