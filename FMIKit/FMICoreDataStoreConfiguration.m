//
//  FMICoreDataStoreConfiguration.m
//  FMIKit
//
//  Created by Florian Mielke on 10.05.16.
//  Copyright © 2016 madeFM. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FMICoreDataStoreConfiguration.h"
#import "FMIFetchCloudStatus.h"

@interface FMICoreDataStoreConfiguration ()

@property (NS_NONATOMIC_IOSONLY) NSURL *localStoreURL;
@property (NS_NONATOMIC_IOSONLY) NSURL *cloudStoreURL;
@property (NS_NONATOMIC_IOSONLY) NSURL *managedObjectModelURL;
@property (copy, NS_NONATOMIC_IOSONLY) NSDictionary *cloudStoreOptions;
@property (copy, NS_NONATOMIC_IOSONLY) NSDictionary *localStoreOptions;
@property (NS_NONATOMIC_IOSONLY) FMIFetchCloudStatus *fetchCloudStatus;

@end

@implementation FMICoreDataStoreConfiguration

- (instancetype)initWithManagedObjectModelURL:(NSURL *)managedObjectModelURL fetchCloudStatus:(FMIFetchCloudStatus *)fetchCloudStatus localStoreURL:(NSURL *)localStoreURL localStoreOptions:(NSDictionary *)localStoreOptions cloudStoreURL:(NSURL *)cloudStoreURL cloudStoreOptions:(NSDictionary *)cloudStoreOptions {
    self = [super init];
    if (self) {
        self.localStoreURL = localStoreURL;
        self.cloudStoreURL = cloudStoreURL;
        self.managedObjectModelURL = managedObjectModelURL;
        self.cloudStoreOptions = cloudStoreOptions;
        self.localStoreOptions = localStoreOptions;
        self.fetchCloudStatus = fetchCloudStatus;
    }
    return self;
}

- (NSURL *)currentStoreURL {
    return ([self.fetchCloudStatus fetchCloudStatus] == FMICloudStatusEnabled) ? self.cloudStoreURL  : self.localStoreURL;
}

- (NSDictionary *)currentStoreOptions {
    return ([self.fetchCloudStatus fetchCloudStatus] == FMICloudStatusEnabled) ? [self.cloudStoreOptions copy] : [self.localStoreOptions copy];
}

@end
