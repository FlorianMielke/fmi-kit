extension NSError {
    @objc public var shortMessaged: String {
        return [localizedFailureReason, localizedRecoverySuggestion].compactMap { $0 }.joined(separator: "\n\n")
    }
    
    @objc public var mediumMessaged: String {
        return [localizedDescription, localizedFailureReason, localizedRecoverySuggestion].compactMap { $0 }.joined(separator: "\n\n")
    }
    
    @objc public var longMessaged: String {
        return [localizedDescription, localizedFailureReason, localizedRecoverySuggestion, userInfo.description].compactMap { $0 }.joined(separator: "\n\n")
    }

    @objc public var completeMessages: String {
        var message = shortMessaged
        if let underlyingError = userInfo[NSUnderlyingErrorKey] as? NSError {
            message += "\n\n\(underlyingError.mediumMessaged)"
        }
        return message
    }

    @objc public var logFiled: String {
        var message = mediumMessaged
        if let underlyingError = userInfo[NSUnderlyingErrorKey] as? NSError {
            message += "\n\n\(underlyingError.userInfo)"
        }
        return message
    }
}
