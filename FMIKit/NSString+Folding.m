//
//  NSString+Folding
//
//  Created by Florian Mielke on 27.04.12.
//  Copyright (c) 2012 Florian Mielke. All rights reserved.
//

#import "NSString+Folding.h"


@implementation NSString (Folding)


- (NSString *)stringByFoldingToOctects:(NSInteger)numberOfOctets
{
    if (numberOfOctets == 0) {
        return [self copy];
    }
    
    NSMutableString *foldedString = [NSMutableString string];
    NSInteger convertedBytes = 0;
    NSData *stringData = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    BOOL isFirstLine = YES;
    
    while (convertedBytes < [stringData length])
    {
        NSString *subString = nil;
        NSUInteger usedLength = (numberOfOctets - 1);
        
        if (!isFirstLine) {
            usedLength--;
        }
        
        // Calculate the remainder for the last line.
        if ((convertedBytes + usedLength) > [stringData length]) {
            usedLength = [stringData length] - convertedBytes;
        }
        
        subString = [NSString substringFromData:stringData inRange:NSMakeRange(convertedBytes, usedLength) encoding:NSUTF8StringEncoding];
        
        if (isFirstLine)
        {
            [foldedString appendString:subString];
            isFirstLine = NO;
        }
        else
        {
            [foldedString appendFormat:@"\n %@", subString];
        }
        
        convertedBytes += usedLength;
    }
    
    return [foldedString copy];
}


+ (NSString *)substringFromData:(NSData *)stringData inRange:(NSRange)range encoding:(NSStringEncoding)encoding
{
    if (stringData == nil
        || range.length == 0
        || (range.length + range.location) > [stringData length]) {
        return nil;
    }
    
    NSString *subString = nil;
    NSUInteger usedLength = range.length;
    
    while (subString == nil)
    {
        NSData *data = [stringData subdataWithRange:NSMakeRange(range.location, usedLength)];
        subString = [[NSString alloc] initWithData:data encoding:encoding];
        
        if (subString == nil)
        {
            usedLength--;
            
            if (usedLength == 0) {
                return nil;
            }
        }
    }
    
    return subString;
}


@end
