//
//  FMIDatePickerController.m
//
//  Created by Florian Mielke on 14.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIDatePickerController.h"


@interface FMIDatePickerController ()

@property (weak, NS_NONATOMIC_IOSONLY) UITableView *tableView;
@property (NS_NONATOMIC_IOSONLY) NSIndexPath *indexPath;
@property (NS_NONATOMIC_IOSONLY) UIDatePicker *datePicker;
@property (NS_NONATOMIC_IOSONLY) BOOL showsDatePicker;
@property (NS_NONATOMIC_IOSONLY) UIDatePickerMode datePickerModeForDatePicker;
@property (NS_NONATOMIC_IOSONLY) NSTimeZone *timeZoneForDatePicker;
@property (NS_NONATOMIC_IOSONLY) NSDate *dateForDatePicker;

@end



@implementation FMIDatePickerController


#pragma mark - Initialization

- (instancetype)initWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == nil || indexPath == nil) {
        return nil;
    }
    
    self = [super init];
    
    if (self != nil)
    {
        _indexPath = indexPath;
        _tableView = tableView;
        _showsDatePicker = NO;
        _datePickerModeForDatePicker = UIDatePickerModeDateAndTime;
    }
    
    return self;
}


- (instancetype)init
{
    [[NSException exceptionWithName:@"FMInvalidInitializerCall" reason:@"Use initWithTableView:forIndexPath: instead" userInfo: nil] raise];
    
    return nil;
}



#pragma mark - Date picker configuration

- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode
{
    _datePickerModeForDatePicker = datePickerMode;
    [self updateDatePicker:[self datePicker] withDatePickerMode:[self datePickerModeForDatePicker]];
}


- (void)setTimeZone:(NSTimeZone *)timeZone
{
    _timeZoneForDatePicker = timeZone;
    [self updateDatePicker:[self datePicker] withTimeZone:[self timeZoneForDatePicker]];
}


- (void)setDate:(NSDate *)date
{
    _dateForDatePicker = date;
    [self updateDatePicker:[self datePicker] withDate:[self dateForDatePicker]];
}



#pragma mark - Validation

- (BOOL)isDatePickerRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([[self indexPath] compare:indexPath] == NSOrderedSame);
}



#pragma mark - Apperance

- (CGFloat)estimatedHeightForDatePickerRow
{
    return ([self showsDatePicker]) ? [[self datePicker] frame].size.height : 0.0;
}


- (void)toggleDatePicker
{
    [self setShowsDatePicker:!([self showsDatePicker])];
    
    [self informDelegateAboutWillToogle];
    [self askDelegateAboutBalancedToggleForCompoundControllerIfNeeded];
    [self prepareDatePickerRowIfNeeded];
    
    [[self tableView] beginUpdates];
    [[self tableView] endUpdates];
    
    [self informDelegateAboutDidToogle];
}


- (void)balancedToggleDatePicker
{
    [self setShowsDatePicker:!([self showsDatePicker])];
}



#pragma mark - Date picker

- (void)datePickerDidChange:(id)sender
{
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(datePickerController:didChangeDate:)]) {
        [[self delegate] datePickerController:self didChangeDate:[(UIDatePicker *)sender date]];
    }
}


- (void)prepareDatePickerRowIfNeeded
{
    if ([self showsDatePicker])
    {
        [self loadDatePickerIfNeeded];
        
        UITableViewCell *datePickerCell = [[self tableView] cellForRowAtIndexPath:[self indexPath]];
        [[datePickerCell contentView] addSubview:[self datePicker]];
    }
}


- (void)loadDatePickerIfNeeded
{
    if ([self datePicker] == nil)
    {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        [self updateDatePicker:datePicker withDatePickerMode:[self datePickerModeForDatePicker]];
        [self updateDatePicker:datePicker withTimeZone:[self timeZoneForDatePicker]];
        [self updateDatePicker:datePicker withDate:[self dateForDatePicker]];
        [datePicker addTarget:self action:@selector(datePickerDidChange:) forControlEvents:UIControlEventValueChanged];
        
        [self setDatePicker:datePicker];
    }
}


- (void)updateDatePicker:(UIDatePicker *)datePicker withDatePickerMode:(UIDatePickerMode)datePickerMode
{
    [datePicker setDatePickerMode:datePickerMode];
}


- (void)updateDatePicker:(UIDatePicker *)datePicker withTimeZone:(NSTimeZone *)timeZone
{
    [datePicker setTimeZone:timeZone];
}


- (void)updateDatePicker:(UIDatePicker *)datePicker withDate:(NSDate *)date
{
    [datePicker setDate:date];
}


- (NSDate *)dateForDatePicker
{
    if (_dateForDatePicker != nil) {
        return _dateForDatePicker;
    }
    
    _dateForDatePicker = [NSDate date];
    return _dateForDatePicker;
}


- (NSTimeZone *)timeZoneForDatePicker
{
    if (_timeZoneForDatePicker != nil) {
        return _timeZoneForDatePicker;
    }
    
    _timeZoneForDatePicker = [NSTimeZone systemTimeZone];
    return _timeZoneForDatePicker;
}



#pragma mark - Delegate

- (void)setDelegate:(id <FMIDatePickerControllerDelegate>)delegate
{
    if (delegate && ![delegate conformsToProtocol:@protocol(FMIDatePickerControllerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol" userInfo:nil] raise];
    }
    
    _delegate = delegate;
}


- (void)informDelegateAboutWillToogle
{
    if ([self showsDatePicker])
    {
        if ([self delegate] && [[self delegate] respondsToSelector:@selector(datePickerControllerWillShowDatePicker:)]) {
            [[self delegate] datePickerControllerWillShowDatePicker:self];
        }
    }
    else
    {
        if ([self delegate] && [[self delegate] respondsToSelector:@selector(datePickerControllerWillHideDatePicker:)]) {
            [[self delegate] datePickerControllerWillHideDatePicker:self];
        }
    }
}


- (void)informDelegateAboutDidToogle
{
    if ([self showsDatePicker])
    {
        if ([self delegate] && [[self delegate] respondsToSelector:@selector(datePickerControllerDidShowDatePicker:)]) {
            [[self delegate] datePickerControllerDidShowDatePicker:self];
        }
    }
    else
    {
        if ([self delegate] && [[self delegate] respondsToSelector:@selector(datePickerControllerDidHideDatePicker:)]) {
            [[self delegate] datePickerControllerDidHideDatePicker:self];
        }
    }
}


- (void)askDelegateAboutBalancedToggleForCompoundControllerIfNeeded
{
    if ([self showsDatePicker] && [self delegate] && [[self delegate] respondsToSelector:@selector(compoundControllerForDatePickerController:)])
    {
        NSArray *compoundController = [[self delegate] compoundControllerForDatePickerController:self];
        [compoundController enumerateObjectsUsingBlock:^(FMIDatePickerController *compoundController, NSUInteger idx, BOOL *stop) {
           
            if (![compoundController isEqual:self] && [compoundController showsDatePicker])
            {
                [compoundController informDelegateAboutWillToogle];
                [compoundController setShowsDatePicker:NO];
                [compoundController informDelegateAboutDidToogle];
            }
            
        }];
    }
}


@end
