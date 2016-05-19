//
//  FMIStoreConfiguration.h
//  FMIKit
//
//  Created by Florian Mielke on 10.05.16.
//  Copyright © 2016 madeFM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMICloudStatus.h"

@class FMIFetchCloudStatus;

NS_ASSUME_NONNULL_BEGIN

@interface FMIStoreConfiguration : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *localStoreURL;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSDictionary *localStoreOptions;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *cloudStoreURL;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSDictionary *cloudStoreOptions;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *managedObjectModelURL;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSDictionary *currentStoreOptions;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *currentStoreURL;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithManagedObjectModelURL:(NSURL *)managedObjectModelURL fetchCloudStatus:(FMIFetchCloudStatus *)fetchCloudStatus localStoreURL:(NSURL *)localStoreURL localStoreOptions:(NSDictionary *)localStoreOptions cloudStoreURL:(NSURL *)cloudStoreURL cloudStoreOptions:(NSDictionary *)cloudStoreOptions;

@end

NS_ASSUME_NONNULL_END