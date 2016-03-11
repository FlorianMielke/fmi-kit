#import <Foundation/Foundation.h>
#import "FMIMessage.h"

@interface FMISupportMessage : NSObject <FMIMessage>

@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *messageBody;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *subject;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSArray *toRecipients;

- (instancetype)initWithBundle:(NSBundle *)bundle;

@end
