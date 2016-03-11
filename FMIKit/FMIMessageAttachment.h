#import <Foundation/Foundation.h>

@interface FMIMessageAttachment : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSData *data;
@property (copy, readonly, NS_NONATOMIC_IOSONLY) NSString *fileName;
@property (copy, readonly, NS_NONATOMIC_IOSONLY) NSString *mimeType;

+ (instancetype)messageAttachmentForData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName;

@end
