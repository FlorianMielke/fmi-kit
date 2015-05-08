//
//  FMICSVFileDescription.m
//
//  Created by Florian Mielke on 02.05.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMICSVFileDescription.h"


@implementation FMICSVFileDescription

- (instancetype)init
{
    self = [super init];
    
    if (self != nil)
    {
        _delimiter = @",";
        _encoding = NSUTF8StringEncoding;
        _encloser = @"\"";
        _skipFirstLine = YES;
        _lineBreak = @"\r\n";
        _fieldDescriptions = @[];
    }
    
    return self;
}

@end
