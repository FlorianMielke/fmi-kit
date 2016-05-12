//
//  FMIStoreConfiguration.m
//  FMIKit
//
//  Created by Florian Mielke on 10.05.16.
//  Copyright © 2016 madeFM. All rights reserved.
//

#import "FMIStoreConfiguration.h"

@implementation FMIStoreConfiguration

- (instancetype)initWithManagedObjectModelURL:(NSURL *)managedObjectModelURL localeStoreURL:(NSURL *)localeStoreURL cloudStoreURL:(NSURL *)cloudStoreURL cloudStoreName:(NSString *)cloudStoreName cloudStatus:(FMICloudStatus)cloudStatus {
    self = [super init];
    if (self) {
        _localeStoreURL = localeStoreURL;
        _cloudStoreURL = cloudStoreURL;
        _cloudStoreName = [cloudStoreName copy];
        _managedObjectModelURL = managedObjectModelURL;
        _cloudEnabled = cloudStatus;
    }
    return self;
}

@end
