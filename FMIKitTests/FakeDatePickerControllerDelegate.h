//
//  Created by Florian Mielke on 28.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMIDatePickerController.h"


@interface FakeDatePickerControllerDelegate : NSObject  <FMIDatePickerControllerDelegate>

@property (NS_NONATOMIC_IOSONLY) NSArray *compoundController;
@property (NS_NONATOMIC_IOSONLY) BOOL informedAboutWillHide;
@property (NS_NONATOMIC_IOSONLY) BOOL informedAboutDidHide;
@property (NS_NONATOMIC_IOSONLY) BOOL informedAboutWillShow;
@property (NS_NONATOMIC_IOSONLY) BOOL informedAboutDidShow;

@end
