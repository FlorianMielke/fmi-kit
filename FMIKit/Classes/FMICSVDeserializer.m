//
//  FMICSVDeserializer.m
//
//  Created by Florian Mielke on 02.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMICSVDeserializer.h"
#import "FMICSVFieldDeserializer.h"
#import "FMICSVFileDescription.h"
#import "NSString+CSV.h"

NSString *const FMICSVDeserializerErrorDomain = @"FMICSVDeserializerErrorDomain";

@implementation FMICSVDeserializer

+ (BOOL)isValidCSVFileAtURL:(NSURL *)fileURL fileDescription:(FMICSVFileDescription *)fileDescription error:(NSError *__autoreleasing *)error {
    NSString *contents = [NSString stringWithContentsOfURL:fileURL encoding:fileDescription.encoding error:&(*error)];
    if (contents == nil) {
        return NO;
    }

    NSArray *lines = [contents componentsSeparatedByString:fileDescription.lineBreak];
    if ([lines count] == 0 || [[lines lastObject] isEqualToString:contents]) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:FMICSVDeserializerErrorDomain code:FMICSVDeserializerInvalidLineEndingError userInfo:nil];
        }

        return NO;
    }

    return YES;
}

+ (NSArray *)objectsWithContentsOfFileAtURL:(NSURL *)fileURL fileDescription:(FMICSVFileDescription *)fileDescription error:(NSError *__autoreleasing *)error {
    if (![FMICSVDeserializer isValidCSVFileAtURL:fileURL fileDescription:fileDescription error:&(*error)]) {
        return @[];
    }

    FMICSVFieldDeserializer *fieldDeserializer = [[FMICSVFieldDeserializer alloc] initWithFieldDescriptions:fileDescription.fieldDescriptions];
    NSString *sourceString = [NSString stringWithContentsOfURL:fileURL encoding:fileDescription.encoding error:error];
    NSArray *sourceRows = [sourceString componentsSeparatedByString:fileDescription.lineBreak];
    NSMutableArray *targetRows = [NSMutableArray arrayWithCapacity:[sourceRows count]];
    BOOL isFirstLine = YES;

    for (NSString *sourceRow in sourceRows) {
        if (isFirstLine && fileDescription.skipFirstLine) {
            isFirstLine = NO;
            continue;
        }

        if ([sourceRow isEqualToString:@""]) {
            continue;
        }

        NSArray *sourceFields = [sourceRow componentsSeparatedByDelimiter:fileDescription.delimiter encloser:fileDescription.encloser];
        NSDictionary *targetObjects = [fieldDeserializer objectsFromFields:sourceFields];

        if (targetObjects == nil) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:FMICSVDeserializerErrorDomain code:FMICSVDeserializerInvalidColumnsError userInfo:nil];
            }

            return @[];
        }

        [targetRows addObject:targetObjects];
    }

    return [targetRows copy];
}

@end
