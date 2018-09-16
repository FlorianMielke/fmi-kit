import UIKit

@objc extension UIView {
    public func glow() {
        let animation = CABasicAnimation.init(keyPath: "opacity")
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.duration = 0.8
        animation.fromValue = 1.0
        animation.toValue = 0.2
        animation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        layer.add(animation, forKey: "glow")
    }
    
    public func stopGlowing() {
        CATransaction.begin()
        layer.removeAnimation(forKey: "glow")
        CATransaction.commit()
    }
}
