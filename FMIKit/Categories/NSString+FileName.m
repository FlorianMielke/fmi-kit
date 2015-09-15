//
//  NSString+FileName.m
//
//  Created by Florian Mielke on 08.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSString+FileName.h"
#import "NSArray+Querying.h"


@implementation NSString (FileName)


+ (NSString *)urlEncodeValue:(NSString *)str
{
    NSCharacterSet *characters = [NSCharacterSet characterSetWithCharactersInString:@":/?#[]@!$&’()*+,;="];
    return [str stringByAddingPercentEncodingWithAllowedCharacters:characters];
}


- (NSString *)validFileName
{
	NSString *validLength = ([self length] > 250) ? [self substringToIndex:250] : self;
	NSCharacterSet *illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>:'"];
    return [[validLength componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@""];
}


- (NSString *)validFileNameWithType:(NSString *)extension
{
    if (extension && [extension length] > 0) {
        return [[self validFileName] stringByAppendingFormat:@".%@", extension];
    }
    
    return [self validFileName];
}


- (NSString *)uniqueFileNameInFileNames:(NSArray *)fileNames
{
    NSString *uniqueFileName = [self validFileName];
    NSString *fileName = [uniqueFileName stringByDeletingPathExtension];
    NSString *pathExtension = [uniqueFileName pathExtension];

    NSUInteger suffix = 1;
    BOOL hasPathExtension = ([pathExtension length] > 0);
    BOOL isUniqueFileName = NO;
    
    do
    {
        isUniqueFileName = (![fileNames containsString:uniqueFileName]);
        
        if (!isUniqueFileName)
        {
            uniqueFileName = [fileName stringByAppendingFormat:@" %lu", (long)suffix];
            
            if (hasPathExtension) {
                uniqueFileName = [uniqueFileName stringByAppendingFormat:@".%@", pathExtension];
            }
            
            suffix++;
        }
    }
    while (!isUniqueFileName);
    
    return uniqueFileName;
}


@end
