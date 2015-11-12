//
//  NSData+FileAdditions.m
//
//  Created by Florian on 08.02.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "NSData+FileAdditions.h"
#import "NSString+FileName.h"

@implementation NSData (FileAdditions)

- (NSURL *)writeToTemporaryDictionaryUsingFileName:(NSString *)fileName type:(NSString *)extension {
    if (!fileName || [fileName length] == 0) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Writing data to disc requires a file name" userInfo:nil] raise];
    }

    NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:[fileName validFileNameWithType:extension]];
    [self writeToFile:filePath atomically:YES];

    return [NSURL fileURLWithPath:filePath];
}

@end
