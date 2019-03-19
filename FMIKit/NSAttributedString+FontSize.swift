extension NSAttributedString {
  @objc public func changeTo(fontSize: CGFloat) -> NSAttributedString {
    guard let output = self.mutableCopy() as? NSMutableAttributedString else {
      return self
    }
    output.beginEditing()
    output.enumerateAttribute(NSAttributedString.Key.font, in: NSRange(location: 0, length: self.length), options: []) { (value, range, stop) -> Void in
      guard let oldFont = value as? UIFont else {
        return
      }
      let newFont = oldFont.withSize(fontSize)
      output.removeAttribute(NSAttributedString.Key.font, range: range)
      output.addAttribute(NSAttributedString.Key.font, value: newFont, range: range)
    }
    output.endEditing()
    return output
  }
}
