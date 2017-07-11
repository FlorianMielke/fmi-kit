#import "NSIndexSet+Initialization.h"

@implementation NSIndexSet (Initialization)

+ (NSIndexSet *)fmi_indexSetFromNumbersInArray:(NSArray <NSNumber *> *)array {
    __block NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [indexSet addIndex:((NSNumber *) obj).unsignedIntegerValue];
        }
    }];
    return indexSet;
}

@end
