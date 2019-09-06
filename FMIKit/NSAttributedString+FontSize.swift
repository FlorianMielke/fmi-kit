extension NSAttributedString {
  @objc public func changeTo(fontSize: CGFloat, defaultFont: UIFont?) -> NSAttributedString {
    guard let output = self.mutableCopy() as? NSMutableAttributedString else {
      return self
    }
    output.beginEditing()
    output.enumerateAttribute(NSAttributedString.Key.font, in: NSRange(location: 0, length: self.length), options: []) { (value, range, stop) -> Void in
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
  
  @objc public func resetTo(font newFont: UIFont) -> NSAttributedString {
    guard let output = self.mutableCopy() as? NSMutableAttributedString else {
      return self
    }
    let range = NSRange(location: 0, length: self.length)
    output.beginEditing()
    output.fixAttributes(in: range)
    output.enumerateAttribute(NSAttributedString.Key.font, in: range, options: []) { (value, range, stop) -> Void in
      output.addAttribute(NSAttributedString.Key.font, value: newFont, range: range)
    }
    output.endEditing()
    return output
  }
  
  @objc public func editable(using newColor: UIColor) -> NSAttributedString {
    guard let output = self.mutableCopy() as? NSMutableAttributedString else {
      return self
    }
    var replacedColor = false
    output.beginEditing()
    output.enumerateAttribute(NSAttributedString.Key.foregroundColor, in: range, options: []) { (value, range, stop) -> Void in
      output.removeAttribute(NSAttributedString.Key.foregroundColor, range: range)
      output.addAttribute(NSAttributedString.Key.foregroundColor, value: newColor, range: range)
      replacedColor = true
    }
    if !replacedColor {
      output.addAttribute(NSAttributedString.Key.foregroundColor, value: newColor, range: range)
    }
    output.endEditing()
    return output
  }
  
  @objc public func resetColor() -> NSAttributedString {
    guard let output = self.mutableCopy() as? NSMutableAttributedString else {
      return self
    }
    output.beginEditing()
    output.enumerateAttribute(NSAttributedString.Key.foregroundColor, in: range, options: []) { (value, range, stop) -> Void in
      output.removeAttribute(NSAttributedString.Key.foregroundColor, range: range)
    }
    output.endEditing()
    return output
  }
  
  private var range: NSRange { NSRange(location: 0, length: self.length) }
}
