//
//  FakeBindingModel.h
//
//  Created by Florian Mielke on 12.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

@import Foundation;

@interface FakeBindingModel : NSObject

@property (nonatomic, copy) NSString *stringValue;
@property (nonatomic, copy) NSString *stringValue2;
@property (nonatomic) NSInteger numericValue;
@property (nonatomic) FakeBindingModel *submodel;

@end
