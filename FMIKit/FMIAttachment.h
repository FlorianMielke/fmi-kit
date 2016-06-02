#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMIAttachment <NSObject>

@property (readonly, NS_NONATOMIC_IOSONLY) NSString *fileName;
@property (readonly, copy, NS_NONATOMIC_IOSONLY) NSString *mimeType;
@property (readonly, NS_NONATOMIC_IOSONLY) NSData *dataRepresentation;

@end

NS_ASSUME_NONNULL_END