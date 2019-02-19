public enum Result<Success, Failure: Error> {
  case success(Success)
  case failure(Failure)
}

public struct AnyError: Swift.Error, CustomStringConvertible {
  public let underlyingError: Swift.Error
  
  public init(_ error: Swift.Error) {
    self.underlyingError = error
  }
  
  public var description: String {
    return String(describing: underlyingError)
  }
}
