//
//  Created by Florian Mielke on 28.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FakeDatePickerControllerDelegate.h"


@implementation FakeDatePickerControllerDelegate


- (NSArray *)compoundControllerForDatePickerController:(FMIDatePickerController *)controller
{
    return [self compoundController];
}


- (void)datePickerController:(FMIDatePickerController *)controller didChangeDate:(NSDate *)date
{
    
}


- (void)datePickerControllerWillShowDatePicker:(FMIDatePickerController *)controller
{
    [self setInformedAboutWillShow:YES];
}


- (void)datePickerControllerDidShowDatePicker:(FMIDatePickerController *)controller
{
    [self setInformedAboutDidShow:YES];
}


- (void)datePickerControllerWillHideDatePicker:(FMIDatePickerController *)controller
{
    [self setInformedAboutWillHide:YES];
}


- (void)datePickerControllerDidHideDatePicker:(FMIDatePickerController *)controller
{
    [self setInformedAboutDidHide:YES];
}


@end
