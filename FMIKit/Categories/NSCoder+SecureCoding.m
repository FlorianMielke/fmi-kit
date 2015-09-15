#import "NSCoder+SecureCoding.h"

@implementation NSCoder (SecureCoding)

- (NSArray *)fmi_secureDecodeArrayForKey:(NSString *)key withElementsConformingToProtocol:(Protocol *)aProtocol {
    NSArray *anArray = [self decodeObjectForKey:key];
    if (![anArray isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if (anArray.count == 0) {
        return anArray;
    }
    BOOL isSecure = YES;
    for (id elements in anArray) {
        if (![elements conformsToProtocol:aProtocol]) {
            isSecure = NO;
        }
    }
    return (isSecure) ? anArray : nil;
}

@end