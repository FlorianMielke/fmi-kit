//
//  FMIStoreConfiguration.h
//  FMIKit
//
//  Created by Florian Mielke on 10.05.16.
//  Copyright © 2016 madeFM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMICloudStatus.h"

@interface FMIStoreConfiguration : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *localStoreURL;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *cloudStoreURL;
@property (readonly, NS_NONATOMIC_IOSONLY) NSDictionary *localStoreOptions;
@property (readonly, NS_NONATOMIC_IOSONLY) NSDictionary *cloudStoreOptions;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *managedObjectModelURL;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithManagedObjectModelURL:(NSURL *)managedObjectModelURL localStoreURL:(NSURL *)localStoreURL localStoreOptions:(NSDictionary *)localStoreOptions cloudStoreURL:(NSURL *)cloudStoreURL cloudStoreOptions:(NSDictionary *)cloudStoreOptions;

@end
