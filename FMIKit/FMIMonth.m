#import "FMIMonth.h"
#import "FMIHelpers.h"

@implementation FMIMonth

- (instancetype)initWithValue:(NSNumber *)value {
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[FMIMonth alloc] initWithValue:[self.value copy]];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;
    return [self isEqualToType:other];
}

- (BOOL)isEqualToType:(FMIMonth *)type {
    if (self == type)
        return YES;
    if (type == nil)
        return NO;
    if (self.value != type.value && ![self.value isEqualToNumber:type.value])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    return [self.value hash];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        FMI_DECODE_OBJ_CLASS(aDecoder, value, NSNumber);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    FMI_ENCODE_OBJ(aCoder, value);
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"value=%@", self.value];
    [description appendString:@">"];
    return description;
}

@end
