//
//  Created by Florian Mielke on 04.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FMINestedTableView;

@protocol FMINestedTableViewDataSource <UITableViewDataSource>

- (NSInteger)nestedTableView:(FMINestedTableView *)nestedTableView numberOfNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)nestedTableView:(FMINestedTableView *)nestedTableView hasNestedRowsForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)nestedTableView:(FMINestedTableView *)nestedTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)nestedTableView:(FMINestedTableView *)nestedTableView cellForNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

@optional
- (BOOL)nestedTableView:(FMINestedTableView *)nestedTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)nestedTableView:(FMINestedTableView *)nestedTableView canEditNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

- (void)nestedTableView:(FMINestedTableView *)nestedTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)nestedTableView:(FMINestedTableView *)nestedTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forNestedRowAtIndexPath:(NSIndexPath *)indexPath nestedItemIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)rootIndexPath;

@end

@protocol FMINestedTableViewDelegate <UITableViewDelegate>

- (void)nestedTableView:(FMINestedTableView *)nestedTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)nestedTableView:(FMINestedTableView *)nestedTableView didSelectNestedRowAtIndex:(NSUInteger)index rootRowIndexPath:(NSIndexPath *)indexPath;

@end

@interface FMINestedTableView : UITableView

@property (weak, NS_NONATOMIC_IOSONLY) id <FMINestedTableViewDataSource> dataSource;
@property (weak, NS_NONATOMIC_IOSONLY) id <FMINestedTableViewDelegate> delegate;
@property (NS_NONATOMIC_IOSONLY) BOOL allowsNestedRows;

- (NSInteger)numberOfVisibleNestedRowsInSection:(NSInteger)section;

- (UITableViewCell *)configuredCellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)adjustedIndexPathForIndexPath:(NSIndexPath *)indexPath;

- (BOOL)showsNestedRows;

- (BOOL)isEditableRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)isNestedRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)passSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)passCommitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)hideNestedRows;

@end

NS_ASSUME_NONNULL_END