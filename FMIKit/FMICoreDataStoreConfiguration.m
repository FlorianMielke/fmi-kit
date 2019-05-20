//
//  FMICoreDataStoreConfiguration.m
//  FMIKit
//
//  Created by Florian Mielke on 10.05.16.
//  Copyright © 2016 madeFM. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FMICoreDataStoreConfiguration.h"

@interface FMICoreDataStoreConfiguration ()

@property (NS_NONATOMIC_IOSONLY) NSURL *localStoreURL;
@property (NS_NONATOMIC_IOSONLY) NSURL *managedObjectModelURL;
@property (copy, NS_NONATOMIC_IOSONLY) NSDictionary *localStoreOptions;

@end

@implementation FMICoreDataStoreConfiguration

- (instancetype)initWithManagedObjectModelURL:(NSURL *)managedObjectModelURL localStoreURL:(NSURL *)localStoreURL localStoreOptions:(NSDictionary *)localStoreOptions {
  self = [super init];
  if (self) {
    self.localStoreURL = localStoreURL;
    self.managedObjectModelURL = managedObjectModelURL;
    self.localStoreOptions = localStoreOptions;
  }
  return self;
}

@end
