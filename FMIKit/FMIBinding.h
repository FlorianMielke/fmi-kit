//
//  FMIBinding.h
//
//  Created by Florian Mielke on 12.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^FMTransformBlock)(id value);


@interface FMIBinding : NSObject

@property (NS_NONATOMIC_IOSONLY) NSObject *observer;
@property (NS_NONATOMIC_IOSONLY) NSObject *subject;
@property (copy, NS_NONATOMIC_IOSONLY) NSString *observerKeyPath;
@property (copy, NS_NONATOMIC_IOSONLY) NSString *subjectKeyPath;
@property (copy, NS_NONATOMIC_IOSONLY) FMTransformBlock transformBlock;

- (void)activate;

- (void)deactivate;

@end
