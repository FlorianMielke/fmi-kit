public protocol Named {
    static var name: String { get }
}

public extension Named {
    static var name: String {
        return String(describing: self)
    }
}
