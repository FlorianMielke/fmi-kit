import UIKit

@objc public class RoundedButton: UIButton {
    private var roundedBackgroundColor: UIColor?
    
    @objc public convenience init(systemName: String, cornerRadius: CGFloat = 6.0, tintColor: UIColor = .label, backgroundColor: UIColor?) {
        self.init(type: .system)
        applyStyle(cornerRadius: cornerRadius, tintColor: tintColor, backgroundColor: backgroundColor)
        setImage(UIImage(systemName: systemName), for: .normal)
    }
    
    @objc public convenience init(title: String, cornerRadius: CGFloat = 6.0, tintColor: UIColor = .label, backgroundColor: UIColor?) {
        self.init(type: .system)
        applyStyle(cornerRadius: cornerRadius, tintColor: tintColor, backgroundColor: backgroundColor)
        setTitle(title, for: .normal)
    }
    
    private func applyStyle(cornerRadius: CGFloat, tintColor: UIColor, backgroundColor: UIColor?) {
        self.tintColor = tintColor
        setTitleColor(tintColor, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        if let backgroundColor = backgroundColor {
            layer.backgroundColor = backgroundColor.cgColor
        }
        layer.cornerRadius = cornerRadius
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard let backgroundColor = roundedBackgroundColor else {
            return
        }

        layer.backgroundColor = backgroundColor.cgColor
    }
}
