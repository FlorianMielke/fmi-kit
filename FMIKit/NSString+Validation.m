//
//  NSString+Validation.m
//
//  Created by Florian Mielke on 25.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSString+Validation.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Validation)


- (BOOL)isNumeric
{
    NSCharacterSet *nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet:nonNumbers];
    
    return r.location == NSNotFound;
}


@end
