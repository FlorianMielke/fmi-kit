extension NSAttributedString {
    @objc public func changeTo(fontSize: CGFloat, defaultFont: UIFont?) -> NSAttributedString {
        guard let output = self.mutableCopy() as? NSMutableAttributedString else {
            return self
        }
        
        output.beginEditing()
        output.enumerateAttribute(NSAttributedString.Key.font, in: range, options: []) { (value, range, stop) -> Void in
            if let oldFont = value as? UIFont {
                let newFont = oldFont.withSize(fontSize)
                output.removeAttribute(NSAttributedString.Key.font, range: range)
                output.addAttribute(NSAttributedString.Key.font, value: newFont, range: range)
            } else if let defaultFont = defaultFont {
                output.addAttribute(NSAttributedString.Key.font, value: defaultFont, range: range)
            }
        }
        output.endEditing()
        return output
    }
    
    @objc public func resetTo(font newFont: UIFont, color newColor: UIColor) -> NSAttributedString {
        guard let output = self.mutableCopy() as? NSMutableAttributedString else {
            return self
        }
        output.beginEditing()

        output.fixAttributes(in: range)
        output.removeAttribute(NSAttributedString.Key.paragraphStyle, range: range)
        output.removeAttribute(NSAttributedString.Key.shadow, range: range)
        output.removeAttribute(NSAttributedString.Key.textEffect, range: range)
        output.removeAttribute(NSAttributedString.Key.backgroundColor, range: range)
        output.removeAttribute(NSAttributedString.Key.font, range: range)
        output.removeAttribute(NSAttributedString.Key.foregroundColor, range: range)
        
        output.addAttribute(NSAttributedString.Key.font, value: newFont, range: range)
        output.addAttribute(NSAttributedString.Key.foregroundColor, value: newColor, range: range)
        
        output.endEditing()
        return output
    }
    
    @objc public func editable(using newColor: UIColor) -> NSAttributedString {
        guard let output = self.mutableCopy() as? NSMutableAttributedString else {
            return self
        }
        
        output.beginEditing()
        output.removeAttribute(NSAttributedString.Key.foregroundColor, range: range)
        output.addAttribute(NSAttributedString.Key.foregroundColor, value: newColor, range: range)
        output.endEditing()
        return output
    }
    
    @objc public func resetColor() -> NSAttributedString {
        guard let output = self.mutableCopy() as? NSMutableAttributedString else {
            return self
        }
        
        output.beginEditing()
        output.removeAttribute(NSAttributedString.Key.foregroundColor, range: range)
        output.endEditing()
        return output
    }
    
    @objc public func cleaned() -> NSAttributedString {
        guard let output = self.mutableCopy() as? NSMutableAttributedString else {
          return self
        }
        
        output.beginEditing()
        output.enumerateAttributes(in: NSRange(location: 0, length: length), options: []) { (attributes, range, stop) in
            attributes.filter { key, _ in
                Self.validAttributes.contains(key) == false
            }.forEach { key, _ in
                output.removeAttribute(key, range: range)
            }
        }
        output.endEditing()
        return output
    }

    private static let validAttributes: [NSAttributedString.Key] = [.font, .paragraphStyle, .underlineStyle]

    private var range: NSRange { NSRange(location: 0, length: self.length) }
}
