#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCoder (SecureCoding)

- (nullable NSArray *)fmi_secureDecodeArrayForKey:(NSString *)key withElementsConformingToProtocol:(Protocol *)aProtocol;

@end

NS_ASSUME_NONNULL_END