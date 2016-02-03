#import <Foundation/Foundation.h>

@interface FMIMultilevelListNumber : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSUInteger indentationLevel;
@property (copy, readonly, NS_NONATOMIC_IOSONLY) NSString *stringValue;
@property (readonly, NS_NONATOMIC_IOSONLY) NSArray *components;

+ (instancetype)listNumberFromStringValue:(NSString *)stringValue;

+ (instancetype)listNumberFromComponents:(NSArray *)components;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithStringValue:(NSString *)stringValue NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithComponents:(NSArray *)components NS_DESIGNATED_INITIALIZER;

- (NSComparisonResult)compare:(FMIMultilevelListNumber *)anotherListNumber;

@end