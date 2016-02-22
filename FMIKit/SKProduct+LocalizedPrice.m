//
//  SKProduct+LocalizedPrice.m
//
//  Created by Florian Mielke on 13.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "SKProduct+LocalizedPrice.h"

@implementation SKProduct (LocalizedPrice)

- (NSString *)fmi_localizedPrice {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.formatterBehavior = NSNumberFormatterBehavior10_4;
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    numberFormatter.locale = self.priceLocale;
    return [numberFormatter stringFromNumber:self.price];
}

@end
