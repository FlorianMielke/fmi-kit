//
//  FMICoreDataStoreConfiguration.h
//  FMIKit
//
//  Created by Florian Mielke on 10.05.16.
//  Copyright © 2016 madeFM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMICloudStatus.h"

@class FMIFetchCloudStatus;

NS_ASSUME_NONNULL_BEGIN

@interface FMICoreDataStoreConfiguration : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *localStoreURL;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSDictionary *localStoreOptions;
@property (readonly, nullable, NS_NONATOMIC_IOSONLY) NSURL *cloudStoreURL;
@property (readonly, nullable, copy, NS_NONATOMIC_IOSONLY) NSDictionary *cloudStoreOptions;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *managedObjectModelURL;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSDictionary *currentStoreOptions;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *currentStoreURL;
@property (readonly, NS_NONATOMIC_IOSONLY) NSDictionary *localStoreOptionsForCloudRemoval;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithManagedObjectModelURL:(NSURL *)managedObjectModelURL fetchCloudStatus:(nullable FMIFetchCloudStatus *)fetchCloudStatus localStoreURL:(NSURL *)localStoreURL localStoreOptions:(NSDictionary *)localStoreOptions cloudStoreURL:(nullable NSURL *)cloudStoreURL cloudStoreOptions:(nullable NSDictionary *)cloudStoreOptions;

@end

NS_ASSUME_NONNULL_END