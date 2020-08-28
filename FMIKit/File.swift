@objc public class File: NSObject {
    private var coordinator = NSFileCoordinator()
    private var fileManager = FileManager.default
    private let url: URL
    
    @objc init(url: URL) {
        self.url = url
    }
    
    public func open() throws -> Data {
        let shouldStopAccessing = url.startAccessingSecurityScopedResource()
        defer {
            if shouldStopAccessing {
                url.stopAccessingSecurityScopedResource()
            }
        }
        return try Data.init(contentsOf: load())
    }
    
    @objc public func copy(to destinationURL: URL) throws {
        let shouldStopAccessing = url.startAccessingSecurityScopedResource()
        defer {
            if shouldStopAccessing {
                url.stopAccessingSecurityScopedResource()
            }
        }
        let safeURL = try load()
        try fileManager.copyItem(at: safeURL, to: destinationURL)
    }
    
    private func load() throws -> URL {
        var safeURL: URL!
        var error: NSError?
        coordinator.coordinate(readingItemAt: url, options: .withoutChanges, error: &error) { fileURL in
            safeURL = fileURL
        }
        if let error = error {
            url.stopAccessingSecurityScopedResource()
            throw error
        }
        return safeURL
    }
}
