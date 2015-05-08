//
//  Created by Florian Mielke on 28.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;
#import "FMIDatePickerController.h"


@interface FakeDatePickerControllerDelegate : NSObject  <FMIDatePickerControllerDelegate>

@property (nonatomic, strong) NSArray *compoundController;
@property (nonatomic, assign) BOOL informedAboutWillHide;
@property (nonatomic, assign) BOOL informedAboutDidHide;
@property (nonatomic, assign) BOOL informedAboutWillShow;
@property (nonatomic, assign) BOOL informedAboutDidShow;

@end
