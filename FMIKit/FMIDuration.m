//
//  FMIDuration.m
//
//  Created by Florian Mielke on 09.08.13.
//  Copyright (c) 2013 Florian Mielke. All rights reserved.
//

#import "FMIDuration.h"

static NSString *const FMIDurationEncodingTimeIntervalKey = @"timeInterval";

@interface FMIDuration ()

@property (NS_NONATOMIC_IOSONLY) NSTimeInterval timeInterval;

@end

@implementation FMIDuration

+ (FMIDuration *)duration {
    return [[FMIDuration alloc] initWithTimeInterval:0];
}

+ (FMIDuration *)durationWithTimeInterval:(NSTimeInterval)seconds {
    return [[FMIDuration alloc] initWithTimeInterval:seconds];
}

+ (FMIDuration *)twentyFourHours {
    return [[FMIDuration alloc] initWithTimeInterval:86400];
}

- (instancetype)initWithTimeInterval:(NSTimeInterval)seconds {
    self = [super init];
    if (self) {
        self.timeInterval = seconds;
    }
    return self;
}

- (instancetype)init {
    return [self initWithTimeInterval:0];
}

- (NSInteger)hours {
    return round([self timeIntervalAsMinutes] / 60);
}

- (NSInteger)minutes {
    return ([self timeIntervalAsMinutes] % 60);
}

- (NSInteger)seconds {
    return fmod(fabs(self.timeInterval), 60);
}

- (BOOL)isNegative {
    return (self.timeInterval < 0);
}

- (NSInteger)timeIntervalAsMinutes {
    return roundl(fabs(self.timeInterval) / 60);
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
    if (!duration) {
        return NO;
    }
    BOOL hasEqualTimeInterval = (self.timeInterval == duration.timeInterval);
    return hasEqualTimeInterval;
}

- (NSComparisonResult)compare:(FMIDuration *)anotherDuration {
    NSComparisonResult result = NSOrderedAscending;
    if (self.timeInterval == anotherDuration.timeInterval) {
        result = NSOrderedSame;
    } else if (self.timeInterval > anotherDuration.timeInterval) {
        result = NSOrderedDescending;
    }

    return result;
}

- (id)copyWithZone:(NSZone *)zone {
    FMIDuration *copy = [[[self class] alloc] init];
    if (copy) {
        [copy setTimeInterval:self.timeInterval];
    }
    return copy;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.timeInterval = [aDecoder decodeDoubleForKey:FMIDurationEncodingTimeIntervalKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:self.timeInterval forKey:FMIDurationEncodingTimeIntervalKey];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<FMIDuration: %p, Seconds: %0.f>", self, self.timeInterval];
}

@end
