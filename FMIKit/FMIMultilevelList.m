#import "FMIMultilevelList.h"
#import "FMIMultilevelListNumber.h"
#import "FMIMultilevelListItem.h"

@interface FMIMultilevelList ()

@property (NS_NONATOMIC_IOSONLY) NSArray *items;

@end

@implementation FMIMultilevelList

- (instancetype)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

- (void)removeItemAtIndex:(NSUInteger)index {
    if (self.items.count > 0 && index <= self.items.count - 1) {
        [self updateListNoMovingItemFromIndex:index toIndex:NSUIntegerMax indentationLevel:0];
    }
}

- (BOOL)insertItem:(id <FMIMultilevelListItem>)listItem atIndex:(NSUInteger)index {
    BOOL isValidIndex = index <= self.items.count;
    if (!isValidIndex) {
        return NO;
    }
    NSMutableArray *mutableItems = [self.items mutableCopy];
    [mutableItems insertObject:listItem atIndex:index];
    self.items = [mutableItems copy];
    [self updateListNoMovingItemFromIndex:0 toIndex:index indentationLevel:0];
    return YES;
}

- (void)removeItem:(id <FMIMultilevelListItem>)item {
    NSUInteger currentIndex = [self.items indexOfObject:item];
    if (currentIndex == NSNotFound)
        return;
    NSMutableArray *mutableItems = [self.items mutableCopy];
    [mutableItems removeObject:item];
    self.items = [mutableItems copy];
    if (self.items.count > 0) {
        [self updateListNoMovingItemFromIndex:currentIndex toIndex:NSUIntegerMax indentationLevel:0];
    }
}

- (void)moveItem:(id <FMIMultilevelListItem>)item fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex indentationLevel:(NSUInteger)indentationLevel {
    NSMutableArray *updatedItems = [self.items mutableCopy];
    [updatedItems removeObject:item];
    [updatedItems insertObject:item atIndex:toIndex];
    self.items = [updatedItems copy];
    [self updateListNoMovingItemFromIndex:fromIndex toIndex:toIndex indentationLevel:indentationLevel];
}

- (void)updateListNoMovingItemFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex indentationLevel:(NSUInteger)indentationLevel {
    NSUInteger startIndex = MIN(toIndex, fromIndex);
    __block FMIMultilevelListNumber *previousListNo = [self listNoBeforeIndex:startIndex];
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(startIndex, self.items.count - startIndex)];
    [self.items enumerateObjectsAtIndexes:indexes options:0 usingBlock:^(id <FMIMultilevelListItem> currentItem, NSUInteger idx, BOOL *stop) {
        FMIMultilevelListNumber *currentItemNo = currentItem.listNumber;
        FMIMultilevelListNumber *newListNo;
        BOOL isFirstItem = (idx == 0);
        if (isFirstItem) {
            newListNo = [FMIMultilevelListNumber listNumberFromComponents:@[@1]];
        } else {
            BOOL isMovedItem = (idx == toIndex);
            BOOL isItemIndented = (isMovedItem) ? (indentationLevel > 0) : (currentItemNo.indentationLevel > 0);
            newListNo = [self listNoAfterListNo:previousListNo indented:isItemIndented];
        }
        currentItem.listNumber = newListNo;
        previousListNo = newListNo;
    }];
}

- (FMIMultilevelListNumber *)listNoBeforeIndex:(NSUInteger)index {
    NSInteger previousIndex = (index - 1);
    BOOL isFirstItem = (previousIndex < 0);
    if (!isFirstItem) {
        id <FMIMultilevelListItem> previousItem = self.items[previousIndex];
        return previousItem.listNumber;
    }
    return nil;
}

- (FMIMultilevelListNumber *)listNoAfterListNo:(FMIMultilevelListNumber *)listNo indented:(BOOL)indented {
    return (indented) ? [self indentedListNoAfterListNo:listNo] : [self listNoAfterListNo:listNo];
}

- (FMIMultilevelListNumber *)listNoAfterListNo:(FMIMultilevelListNumber *)listNo {
    return [FMIMultilevelListNumber listNumberFromComponents:@[@([listNo.components[0] integerValue] + 1)]];
}

- (FMIMultilevelListNumber *)indentedListNoAfterListNo:(FMIMultilevelListNumber *)listNo {
    BOOL isListNoIndented = (listNo.indentationLevel > 0);
    NSUInteger firstComponent = MAX(1, [listNo.components[0] integerValue]);
    NSArray *components = (isListNoIndented) ? @[@(firstComponent), @([listNo.components[1] integerValue] + 1)] : @[@(firstComponent), @1];
    return [FMIMultilevelListNumber listNumberFromComponents:components];
}
@end
