public extension UIViewController  {
    func handle(_ error: NSError, retryHandler: (() -> Void)?) {
        handle(error, from: self, retryHandler: retryHandler)
    }
}
