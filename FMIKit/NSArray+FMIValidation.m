//
//  NSArray+FMIValidation.m
//  FMINestableTableViewDemo
//
//  Created by Florian Mielke on 15.06.16.
//  Copyright © 2016 Florian Mielke. All rights reserved.
//

#import "NSArray+FMIValidation.h"

@implementation NSArray (FMIValidation)

- (BOOL)fmi_validateIndex:(NSUInteger)index {
    return (self.count > index);
}

@end
