//
//  FMIMessageAttachment.m
//
//  Created by Florian on 10.04.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIMessageAttachment.h"


@interface FMIMessageAttachment ()

@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *mimeType;

@end



@implementation FMIMessageAttachment


#pragma mark -
#pragma mark Initialization

+ (id)messageAttachmentForData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName
{
    id messageAttachment = nil;
    
    if ([data length] > 0 && [mimeType length] > 0 && [fileName length] > 0)
    {
        messageAttachment = [[FMIMessageAttachment alloc] init];
        
        [messageAttachment setData:data];
        [messageAttachment setMimeType:mimeType];
        [messageAttachment setFileName:fileName];
    }
    
    return messageAttachment;
}


@end
