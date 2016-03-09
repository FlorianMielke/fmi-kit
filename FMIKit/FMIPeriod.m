#import "FMIPeriod.h"
#import "FMIHelpers.h"

@implementation FMIPeriod

- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    self = [super init];
    if (self) {
        _startDate = startDate;
        _endDate = endDate;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[FMIPeriod alloc] initWithStartDate:[self.startDate copy] endDate:[self.endDate copy]];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;
    return [self isEqualToPeriod:other];
}

- (BOOL)isEqualToPeriod:(FMIPeriod *)period {
    if (self == period)
        return YES;
    if (period == nil)
        return NO;
    if (self.startDate != period.startDate && ![self.startDate isEqualToDate:period.startDate])
        return NO;
    if (self.endDate != period.endDate && ![self.endDate isEqualToDate:period.endDate])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.startDate hash];
    hash = hash * 31u + [self.endDate hash];
    return hash;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        FMI_DECODE_OBJ_CLASS(aDecoder, startDate, NSDate);
        FMI_DECODE_OBJ_CLASS(aDecoder, endDate, NSDate);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    FMI_ENCODE_OBJ(aCoder, startDate);
    FMI_ENCODE_OBJ(aCoder, endDate);
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"startDate=%@", self.startDate];
    [description appendFormat:@"endDate=%@", self.endDate];
    [description appendString:@">"];
    return description;
}

@end
