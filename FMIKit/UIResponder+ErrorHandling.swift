extension UIResponder {
    @objc open func handle(_ error: NSError, errorHandler: ErrorHandler, retryHandler: @escaping () -> Void) {
        // This assertion will help us identify errors that were either emitted by a view controller *before* it was added to the responder chain, or never handled at all:
        guard let nextResponder = next else {
            return assertionFailure("""
                Unhandled error \(error) from \(errorHandler)
                """)
        }
        nextResponder.handle(error, errorHandler: errorHandler, retryHandler: retryHandler)
    }
}
