//
//  FMIStoreConfiguration.m
//  FMIKit
//
//  Created by Florian Mielke on 10.05.16.
//  Copyright © 2016 madeFM. All rights reserved.
//

#import "FMIStoreConfiguration.h"

@implementation FMIStoreConfiguration

- (instancetype)initWithManagedObjectModelURL:(NSURL *)managedObjectModelURL localStoreURL:(NSURL *)localStoreURL localStoreOptions:(NSDictionary *)localStoreOptions cloudStoreURL:(NSURL *)cloudStoreURL cloudStoreOptions:(NSDictionary *)cloudStoreOptions {
    self = [super init];
    if (self) {
        _localStoreURL = localStoreURL;
        _cloudStoreURL = cloudStoreURL;
        _managedObjectModelURL = managedObjectModelURL;
        _cloudStoreOptions = cloudStoreOptions;
        _localStoreOptions = localStoreOptions;
    }
    return self;
}

@end
