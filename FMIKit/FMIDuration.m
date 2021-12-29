//
//  FMIDuration.m
//
//  Created by Florian Mielke on 09.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIDuration.h"

static NSString *const FMIDurationEncodingTimeIntervalKey = @"timeInterval";

@interface FMIDuration ()

@property (NS_NONATOMIC_IOSONLY) NSTimeInterval seconds;

@end

@implementation FMIDuration

+ (FMIDuration *)zero {
    return [[FMIDuration alloc] initWithSeconds:0];
}

+ (FMIDuration *)durationWithSeconds:(NSTimeInterval)seconds {
    return [[FMIDuration alloc] initWithSeconds:seconds];
}

- (instancetype)initWithSeconds:(NSTimeInterval)seconds {
    self = [super init];
    if (self) {
        self.seconds = seconds;
    }
    return self;
}

- (instancetype)init {
    return [self initWithSeconds:0];
}

- (NSInteger)hours {
    return round([self timeIntervalAsMinutes] / 60);
}

- (NSInteger)minutes {
    return ([self timeIntervalAsMinutes] % 60);
}

- (BOOL)isNegative {
    return (self.seconds < 0);
}

- (NSInteger)timeIntervalAsMinutes {
    return roundl(fabs(self.seconds) / 60);
}

- (NSDecimal)decimalValue {
    return [@(self.seconds) decimalValue];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[FMIDuration class]]) {
        return NO;
    }
    return [self isEqualToDuration:object];
}

- (BOOL)isEqualToDuration:(FMIDuration *)duration {
    if (duration == nil) {
        return NO;
    }
    BOOL hasEqualSeconds = (self.seconds == duration.seconds);
    return hasEqualSeconds;
}

- (NSComparisonResult)compare:(FMIDuration *)anotherDuration {
    NSComparisonResult result = NSOrderedAscending;
    if (self.seconds == anotherDuration.seconds) {
        result = NSOrderedSame;
    } else if (self.seconds > anotherDuration.seconds) {
        result = NSOrderedDescending;
    }

    return result;
}

- (id)copyWithZone:(NSZone *)zone {
    FMIDuration *copy = [[[self class] alloc] init];
    if (copy) {
        [copy setSeconds:self.seconds];
    }
    return copy;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.seconds = [aDecoder decodeDoubleForKey:FMIDurationEncodingTimeIntervalKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:self.seconds forKey:FMIDurationEncodingTimeIntervalKey];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<FMIDuration: %p, seconds: %0.f>", self, self.seconds];
}

@end
