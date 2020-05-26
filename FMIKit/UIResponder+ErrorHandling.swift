extension UIResponder {
    @objc open func handle(_ error: NSError, from viewController: UIViewController, retryHandler: (() -> Void)?) {
        // This assertion will help us identify errors that were either emitted by a view controller *before* it was added to the responder chain, or never handled at all:
        guard let nextResponder = next else {
            return assertionFailure("""
                Unhandled error \(error) from \(viewController)
                """)
        }
        nextResponder.handle(error, from: viewController, retryHandler: retryHandler)
    }
}
