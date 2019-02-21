enum PropertyListError: Error {
  case invalidRootObject
}

public struct PropertyList {
  public let values: Dictionary<String, Any>
  
  init(from values: Dictionary<String, Any>) {
    self.values = values
  }
  
  public static func parse(_ data: Data) throws -> PropertyList {
    let propertyList = try PropertyListSerialization.propertyList(from: data, format: nil)
    guard propertyList is Dictionary<String, Any> else {
      throw PropertyListError.invalidRootObject
    }
    return PropertyList(from: propertyList as! Dictionary<String, Any>)
  }
}
