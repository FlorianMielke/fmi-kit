extension NSError {
    @objc public var shortMessaged: String {
        return [localizedFailureReason, localizedRecoverySuggestion].compactMap { $0 }.joined(separator: "\n\n")
    }
    
    @objc public var completeMessaged: String {
        var message = shortMessaged
        if let underlyingError = userInfo[NSUnderlyingErrorKey] as? NSError {
            message += "\n\n\(underlyingError.longMessaged)"
        }
        return message
    }
    
    @objc public var longMessaged: String {
        return [localizedDescription, localizedFailureReason, localizedRecoverySuggestion, userInfo.description].compactMap { $0 }.joined(separator: "\n\n")
    }
}
