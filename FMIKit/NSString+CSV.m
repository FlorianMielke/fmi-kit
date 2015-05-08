//
//  NSString+CSV.m
//
//  Created by Florian Mielke on 14.02.13.
//  Copyright (c) 2013 Florian Mielke All rights reserved.
//

#import "NSString+CSV.h"


@implementation NSString (CSV)


- (NSString *)stringByEnclosingWithString:(NSString *)encloser
{
    return [NSString stringWithFormat:@"%@%@%@", encloser, self, encloser];
}


- (NSArray *)componentsSeparatedByDelimiter:(NSString *)delimiter encloser:(NSString *)encloser
{
    NSString *trimmedRow = [self copy];
    NSMutableString *separatorString = [NSMutableString string];
    
    // Validate delimiter
    if (delimiter && [delimiter length] > 0)
    {
        [separatorString appendString:delimiter];

        // Validate encloser
        if (encloser && [encloser length] > 0)
        {
            // Trimm encloser at first and last character of string
            NSCharacterSet *encloserCharacterSet = [NSCharacterSet characterSetWithCharactersInString:encloser];
            trimmedRow = [self stringByTrimmingCharactersInSet:encloserCharacterSet];
            
            [separatorString appendString:encloser];
            [separatorString insertString:encloser atIndex:0];
        }
    }

    NSArray *components = [trimmedRow componentsSeparatedByString:separatorString];

    return components;
}


@end
