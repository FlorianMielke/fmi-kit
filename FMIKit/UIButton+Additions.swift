import UIKit

extension UIButton {
    @objc static func make(cornerRadius: CGFloat = 6.0, systemName: String, tintColor: UIColor = .label, backgroundColor: UIColor?) -> UIButton {
        let button = make(cornerRadius: cornerRadius, tintColor: tintColor, backgroundColor: backgroundColor)
        button.setImage(UIImage(systemName: systemName), for: .normal)
        return button
    }

    @objc static func make(cornerRadius: CGFloat = 6.0, title: String, tintColor: UIColor = .label, backgroundColor: UIColor?) -> UIButton {
        let button = make(cornerRadius: cornerRadius, tintColor: tintColor, backgroundColor: backgroundColor)
        button.setTitle(title, for: .normal)
        return button
    }
    
    private static func make(cornerRadius: CGFloat = 6.0, tintColor: UIColor = .label, backgroundColor: UIColor?) -> UIButton {
        let button = UIButton(type: .custom)
        button.tintColor = tintColor
        button.setTitleColor(tintColor, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        if let backgroundColor = backgroundColor {
            button.layer.backgroundColor = backgroundColor.cgColor
        }
        button.layer.cornerRadius = cornerRadius
        return button
    }
}
