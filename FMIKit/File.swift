public struct File {
  static var coordinator: NSFileCoordinator = {
    return NSFileCoordinator()
  }()
  
  public static func open(at url: URL) throws -> Data {
    var safeURL: URL!
    var error: NSError?
    _ = url.startAccessingSecurityScopedResource()
    coordinator.coordinate(readingItemAt: url, options: .withoutChanges, error: &error) { fileURL in
      safeURL = fileURL
    }
    if let error = error {
      _ = url.stopAccessingSecurityScopedResource()
      throw error
    }
    let data = try Data.init(contentsOf: safeURL)
    _ = url.stopAccessingSecurityScopedResource()
    return data
  }
}
