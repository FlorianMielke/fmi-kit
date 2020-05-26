public extension UIViewController  {
    func handle(_ error: NSError, retryHandler: (() -> Void)?, cancelHandler: (() -> Void)?) {
        handle(error, from: self, retryHandler: retryHandler, cancelHandler: cancelHandler)
    }
}
