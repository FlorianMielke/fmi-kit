#import "FMIMultilevelListNumber.h"

@interface FMIMultilevelListNumber ()

@property (copy, NS_NONATOMIC_IOSONLY) NSString *listNumberValue;

@end

@implementation FMIMultilevelListNumber

+ (instancetype)listNumberFromStringValue:(NSString *)stringValue {
    return [[FMIMultilevelListNumber alloc] initWithStringValue:stringValue];
}

+ (instancetype)listNumberFromComponents:(NSArray *)components {
    return [[FMIMultilevelListNumber alloc] initWithComponents:components];
}

- (instancetype)initWithStringValue:(NSString *)stringValue {
    if (!stringValue) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.listNumberValue = stringValue;
    }
    return self;
}

- (instancetype)initWithComponents:(NSArray *)components {
    if (components.count == 0) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.listNumberValue = [components componentsJoinedByString:@"."];
    }
    return self;
}

- (NSString *)stringValue {
    return self.listNumberValue;
}

- (NSArray *)components {
    NSMutableArray *components = [[NSMutableArray alloc] init];
    [[self.stringValue componentsSeparatedByString:@"."] enumerateObjectsUsingBlock:^(NSString *component, NSUInteger idx, BOOL *stop) {
        [components addObject:@((component.integerValue))];
    }];
    return [components copy];
}

- (NSUInteger)indentationLevel {
    NSUInteger countOffset = 1;
    return self.components.count - countOffset;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[FMIMultilevelListNumber class]]) {
        return NO;
    }
    return [self.stringValue isEqualToString:((FMIMultilevelListNumber *) object).stringValue];
}

- (NSComparisonResult)compare:(FMIMultilevelListNumber *)anotherListNumber {
    return [self.stringValue localizedCaseInsensitiveCompare:anotherListNumber.stringValue];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> %@", self.class, self, self.stringValue];
}

@end