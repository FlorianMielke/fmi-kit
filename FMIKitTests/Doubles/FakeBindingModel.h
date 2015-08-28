//
//  FakeBindingModel.h
//
//  Created by Florian Mielke on 12.09.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeBindingModel : NSObject

@property (copy, NS_NONATOMIC_IOSONLY) NSString *stringValue;
@property (copy, NS_NONATOMIC_IOSONLY) NSString *stringValue2;
@property (NS_NONATOMIC_IOSONLY) NSInteger numericValue;
@property (NS_NONATOMIC_IOSONLY) FakeBindingModel *submodel;

@end
