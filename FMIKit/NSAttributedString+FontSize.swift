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
}
