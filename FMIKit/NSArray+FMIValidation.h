//
//  NSArray+FMIValidation.m
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (FMIValidation)

- (BOOL)fmi_validateIndex:(NSUInteger)index;

@end