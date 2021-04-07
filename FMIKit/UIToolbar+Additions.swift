import UIKit

extension UIToolbar {
    @objc static func makeTransparent() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        return toolbar
    }
}
