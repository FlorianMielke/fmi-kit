//
//  SKProduct+LocalizedPrice.h
//
//  Created by Florian Mielke on 13.10.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import <StoreKit/StoreKit.h>


/**
 *	Adds methods to SKProduct for localizing properties.
 */
@interface SKProduct (LocalizedPrice)

/**
 * The price of the product.
 * @return The price is localized based on the priceLocale property.
 */
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *fmi_localizedPrice;

@end
