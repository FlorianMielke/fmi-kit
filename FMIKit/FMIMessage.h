#import <Foundation/Foundation.h>

@protocol FMIAttachment;

NS_ASSUME_NONNULL_BEGIN

@protocol FMIMessage <NSObject>

@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *messageBody;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *subject;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSArray<NSString *> *toRecipients;
@property (readonly, NS_NONATOMIC_IOSONLY) NSArray<id<FMIAttachment>> *attachments;

@end

NS_ASSUME_NONNULL_END
