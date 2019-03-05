@objc public class File: NSObject {
  private var coordinator = NSFileCoordinator()
  private var fileManager = FileManager.default
  private let url: URL
  
  @objc init(url: URL) {
    self.url = url
  }

  public func open() throws -> Data {
    _ = url.startAccessingSecurityScopedResource()
    let data = try Data.init(contentsOf: load())
    _ = url.stopAccessingSecurityScopedResource()
    return data
  }

  @objc public func copy(to destinationURL: URL) throws {
    _ = url.startAccessingSecurityScopedResource()
    let safeURL = try load()
    try fileManager.copyItem(at: safeURL, to: destinationURL)
    _ = url.stopAccessingSecurityScopedResource()
  }

  private func load() throws -> URL {
    var safeURL: URL!
    var error: NSError?
    coordinator.coordinate(readingItemAt: url, options: .withoutChanges, error: &error) { fileURL in
      safeURL = fileURL
    }
    if let error = error {
      _ = url.stopAccessingSecurityScopedResource()
      throw error
    }
    return safeURL
  }
}
