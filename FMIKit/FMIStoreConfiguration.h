//
//  FMIStoreConfiguration.h
//  FMIKit
//
//  Created by Florian Mielke on 10.05.16.
//  Copyright © 2016 madeFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMIStoreConfiguration : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *localeStoreURL;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *cloudStoreURL;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *cloudStoreName;
@property (readonly, NS_NONATOMIC_IOSONLY) NSURL *managedObjectModelURL;
@property (readonly, NS_NONATOMIC_IOSONLY) BOOL cloudEnabled;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithManagedObjectModelURL:(NSURL *)managedObjectModelURL localeStoreURL:(NSURL *)localeStoreURL cloudStoreURL:(NSURL *)cloudStoreURL cloudStoreName:(NSString *)cloudStoreName cloudEnabled:(BOOL)cloudEnabled;

@end
