#import <Foundation/Foundation.h>

@class FMIMessageAttachment;

@protocol FMIMessage <NSObject>

@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *messageBody;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *subject;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSArray *toRecipients;

@optional
@property (readonly, NS_NONATOMIC_IOSONLY) NSArray <FMIMessageAttachment *> *attachments;

@end
