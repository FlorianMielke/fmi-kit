//
//  FMIBinding.m
//
//  Created by Florian Mielke on 12.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIBinding.h"

@implementation FMIBinding

- (void)activate {
    [self.subject addObserver:self forKeyPath:self.subjectKeyPath options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) context:NULL];
}

- (void)deactivate {
    [self.subject removeObserver:self forKeyPath:self.subjectKeyPath];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    id newValue = [change valueForKey:NSKeyValueChangeNewKey];
    if (newValue != [NSNull null]) {
        if (self.transformBlock) {
            newValue = [self transformBlock](newValue);
        }
        [self.observer setValue:newValue forKeyPath:self.observerKeyPath];
    }
}

@end
