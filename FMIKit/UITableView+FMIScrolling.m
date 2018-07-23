#import "UITableView+FMIScrolling.h"
#import "UITableView+IndexPath.h"

@implementation UITableView (FMIScrolling)

- (void)fmi_scrollToNearestRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    if (![self fmi_hasIndexPath:indexPath]) {
        return;
    }
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}

@end
