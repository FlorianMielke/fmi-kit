extension NSError {
    @objc public var messaged: String {
        var message = [localizedFailureReason, localizedRecoverySuggestion].compactMap { $0 }.joined(separator: "\n\n")
        if let underlyingError = userInfo[NSUnderlyingErrorKey] as? NSError {
            message += "\n\n\(underlyingError.fullMessaged)"
        }
        return message
    }
    
    @objc public var fullMessaged: String {
        return [localizedDescription, localizedFailureReason, localizedRecoverySuggestion].compactMap { $0 }.joined(separator: " ")
    }
}
