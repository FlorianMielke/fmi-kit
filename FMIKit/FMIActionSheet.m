#import "FMIActionSheet.h"

@implementation FMIActionSheet

- (void)presentWithTitle:(NSString *)title style:(UIAlertActionStyle)style fromBarButtonItem:(UIBarButtonItem *)fromBarButtonItem popoverArrowDirectionDown:(UIPopoverArrowDirection)popoverArrowDirection viewController:(UIViewController *)viewController actionHandler:(void (^)(UIAlertAction *))actionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:title style:style handler:actionHandler];
    [alertController addAction:alertAction];
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        popover.barButtonItem = fromBarButtonItem;
        popover.permittedArrowDirections = popoverArrowDirection;
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
