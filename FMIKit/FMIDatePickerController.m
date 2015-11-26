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

- (instancetype)initWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    if (tableView == nil || indexPath == nil) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.indexPath = indexPath;
        self.tableView = tableView;
        self.showsDatePicker = NO;
        self.datePickerModeForDatePicker = UIDatePickerModeDateAndTime;
    }
    return self;
}

- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode {
    _datePickerModeForDatePicker = datePickerMode;
    [self updateDatePicker:self.datePicker withDatePickerMode:self.datePickerModeForDatePicker];
}

- (void)setTimeZone:(NSTimeZone *)timeZone {
    _timeZoneForDatePicker = timeZone;
    [self updateDatePicker:self.datePicker withTimeZone:self.timeZoneForDatePicker];
}

- (void)setDate:(NSDate *)date {
    _dateForDatePicker = date;
    [self updateDatePicker:self.datePicker withDate:self.dateForDatePicker];
}

- (BOOL)isDatePickerRowAtIndexPath:(NSIndexPath *)indexPath {
    return ([self.indexPath compare:indexPath] == NSOrderedSame);
}

- (CGFloat)estimatedHeightForDatePickerRow {
    return (CGFloat) (self.showsDatePicker ? CGRectGetHeight(self.datePicker.frame) : 0.0);
}

- (void)toggleDatePicker {
    self.showsDatePicker = !self.showsDatePicker;
    [self informDelegateAboutWillToggle];
    [self askDelegateAboutBalancedToggleForCompoundControllerIfNeeded];
    [self prepareDatePickerRowIfNeeded];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [self informDelegateAboutDidToggle];
}

- (void)balancedToggleDatePicker {
    self.showsDatePicker = !self.showsDatePicker;
}

- (void)datePickerDidChange:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerController:didChangeDate:)]) {
        [self.delegate datePickerController:self didChangeDate:[(UIDatePicker *) sender date]];
    }
}

- (void)prepareDatePickerRowIfNeeded {
    if (self.showsDatePicker) {
        [self loadDatePickerIfNeeded];
        UITableViewCell *datePickerCell = [self.tableView cellForRowAtIndexPath:self.indexPath];
        [datePickerCell.contentView addSubview:self.datePicker];
    }
}

- (void)loadDatePickerIfNeeded {
    if (!self.datePicker) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        [self updateDatePicker:datePicker withDatePickerMode:self.datePickerModeForDatePicker];
        [self updateDatePicker:datePicker withTimeZone:self.timeZoneForDatePicker];
        [self updateDatePicker:datePicker withDate:self.dateForDatePicker];
        [datePicker addTarget:self action:@selector(datePickerDidChange:) forControlEvents:UIControlEventValueChanged];
        self.datePicker = datePicker;
    }
}

- (void)updateDatePicker:(UIDatePicker *)datePicker withDatePickerMode:(UIDatePickerMode)datePickerMode {
    datePicker.datePickerMode = datePickerMode;
}

- (void)updateDatePicker:(UIDatePicker *)datePicker withTimeZone:(NSTimeZone *)timeZone {
    datePicker.timeZone = timeZone;
}

- (void)updateDatePicker:(UIDatePicker *)datePicker withDate:(NSDate *)date {
    datePicker.date = date;
}

- (NSDate *)dateForDatePicker {
    if (_dateForDatePicker) {
        return _dateForDatePicker;
    }
    _dateForDatePicker = [NSDate date];
    return _dateForDatePicker;
}

- (NSTimeZone *)timeZoneForDatePicker {
    if (_timeZoneForDatePicker) {
        return _timeZoneForDatePicker;
    }
    _timeZoneForDatePicker = [NSTimeZone systemTimeZone];
    return _timeZoneForDatePicker;
}

- (void)setDelegate:(id <FMIDatePickerControllerDelegate>)delegate {
    if (delegate && ![delegate conformsToProtocol:@protocol(FMIDatePickerControllerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol" userInfo:nil] raise];
    }
    _delegate = delegate;
}

- (void)informDelegateAboutWillToggle {
    if (self.showsDatePicker) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerControllerWillShowDatePicker:)]) {
            [self.delegate datePickerControllerWillShowDatePicker:self];
        }
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerControllerWillHideDatePicker:)]) {
            [self.delegate datePickerControllerWillHideDatePicker:self];
        }
    }
}

- (void)informDelegateAboutDidToggle {
    if (self.showsDatePicker) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerControllerDidShowDatePicker:)]) {
            [self.delegate datePickerControllerDidShowDatePicker:self];
        }
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerControllerDidHideDatePicker:)]) {
            [self.delegate datePickerControllerDidHideDatePicker:self];
        }
    }
}

- (void)askDelegateAboutBalancedToggleForCompoundControllerIfNeeded {
    if (self.showsDatePicker && self.delegate && [self.delegate respondsToSelector:@selector(compoundControllerForDatePickerController:)]) {
        NSArray *compoundController = [self.delegate compoundControllerForDatePickerController:self];
        [compoundController enumerateObjectsUsingBlock:^(FMIDatePickerController *compoundController, NSUInteger idx, BOOL *stop) {
            if (![compoundController isEqual:self] && [compoundController showsDatePicker]) {
                [compoundController informDelegateAboutWillToggle];
                [compoundController setShowsDatePicker:NO];
                [compoundController informDelegateAboutDidToggle];
            }
        }];
    }
}

@end
