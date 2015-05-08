//
//  FMIBinding.h
//
//  Created by Florian Mielke on 12.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;

typedef id (^FMTransformBlock)(id value);


@interface FMIBinding : NSObject

@property (nonatomic, retain) NSObject *observer;
@property (nonatomic, copy) NSString *observerKeyPath;
@property (nonatomic, retain) NSObject *subject;
@property (nonatomic, copy) NSString *subjectKeyPath;
@property (nonatomic, copy) FMTransformBlock transformBlock;

- (void)activate;

- (void)deactivate;

@end
