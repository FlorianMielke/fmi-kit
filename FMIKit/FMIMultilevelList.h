#import <Foundation/Foundation.h>

@protocol FMIMultilevelListItem;

@interface FMIMultilevelList : NSObject

@property (readonly, NS_NONATOMIC_IOSONLY) NSArray *items;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithItems:(NSArray *)items NS_DESIGNATED_INITIALIZER;

- (void)removeItemAtIndex:(NSUInteger)index;

- (void)removeItem:(id <FMIMultilevelListItem>)item;

- (void)moveItem:(id <FMIMultilevelListItem>)item fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex indentationLevel:(NSUInteger)indentationLevel;

@end