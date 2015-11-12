//
//  FMIBindingManager.m
//
//  Created by Florian Mielke on 10.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIBindingManager.h"
#import "FMIBinding.h"

@interface FMIBindingManager ()

@property(NS_NONATOMIC_IOSONLY) NSMutableArray *bindings;
@property(NS_NONATOMIC_IOSONLY) BOOL enabled;

@end

@implementation FMIBindingManager

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.bindings = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    if (_enabled) {
        [self disable];
    }
}

- (void)bindObserver:(NSObject *)observer keyPath:(NSString *)observerKeyPath toSubject:(NSObject *)subject keyPath:(NSString *)subjectKeyPath {
    [self bindObserver:observer keyPath:observerKeyPath toSubject:subject keyPath:subjectKeyPath withValueTransform:nil];
}

- (void)bindObserver:(NSObject *)observer keyPath:(NSString *)observerKeyPath toSubject:(NSObject *)subject keyPath:(NSString *)subjectKeyPath withValueTransform:(id (^)(id value))transformBlock {
    FMIBinding *binding = [[FMIBinding alloc] init];
    [binding setObserver:observer];
    [binding setObserverKeyPath:observerKeyPath];
    [binding setSubject:subject];
    [binding setSubjectKeyPath:subjectKeyPath];
    [binding setTransformBlock:transformBlock];
    [self.bindings addObject:binding];
    if (self.isEnabled) {
        [binding activate];
    }
}

- (void)enable {
    if (!self.isEnabled) {
        for (FMIBinding *binding in [self bindings]) {
            [binding activate];
        }
    }
    else {
        NSLog(@"WARNING: FMIBindingManger: attempted to enable already-enabled instance");
    }
    self.enabled = YES;
}

- (void)disable {
    if (self.isEnabled) {
        for (FMIBinding *binding in [self bindings]) {
            [binding deactivate];
        }
    }
    else {
        NSLog(@"WARNING: FMIBindingManger: attempted to disable already-disabled instance");
    }
    self.enabled = NO;
}

- (BOOL)isEnabled {
    return self.enabled;
}


- (void)removeAllBindings {
    if ([self isEnabled]) {
        for (FMIBinding *binding in self.bindings) {
            [binding deactivate];
        }
    }

    [self.bindings removeAllObjects];
}

@end
