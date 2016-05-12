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
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *cloudStoreName;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *managedObjectModelURL;
@property (readonly, NS_NONATOMIC_IOSONLY) FMICloudStatus cloudStatus;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithManagedObjectModelURL:(NSURL *)managedObjectModelURL localStoreURL:(NSURL *)localStoreURL localStoreOptions:(NSDictionary *)localStoreOptions cloudStoreURL:(NSURL *)cloudStoreURL cloudStoreName:(NSString *)cloudStoreName cloudStoreOptions:(NSDictionary *)cloudStoreOptions cloudStatus:(FMICloudStatus)cloudStatus;

@end
