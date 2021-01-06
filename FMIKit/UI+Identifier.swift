@objc public extension UIStoryboardSegue {
    @objc static var identifier: String {
        return String(describing: self)
    }
}

@objc public extension UITableViewCell {
  @objc static var identifier: String {
    return String(describing: self)
  }
}

@objc public extension UICollectionViewCell {
  @objc static var identifier: String {
    return String(describing: self)
  }
}

@objc public extension UIViewController {
  @objc static var identifier: String {
    return String(describing: self)
  }
}

@objc public extension UITableViewHeaderFooterView {
  @objc static var identifier: String {
    return String(describing: self)
  }
}

