#import "FMIMessageAttachment.h"

@interface FMIMessageAttachment ()

@property (NS_NONATOMIC_IOSONLY) NSData *data;
@property (copy, NS_NONATOMIC_IOSONLY) NSString *fileName;
@property (copy, NS_NONATOMIC_IOSONLY) NSString *mimeType;

@end

@implementation FMIMessageAttachment

+ (instancetype)messageAttachmentForData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName {
    FMIMessageAttachment *messageAttachment;
    if (data.length > 0 && mimeType.length > 0 && fileName.length > 0) {
        messageAttachment = [[FMIMessageAttachment alloc] init];
        messageAttachment.data = data;
        messageAttachment.mimeType = mimeType;
        messageAttachment.fileName = fileName;
    }
    return messageAttachment;
}

@end
