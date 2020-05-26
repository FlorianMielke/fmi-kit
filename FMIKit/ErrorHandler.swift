@objc public protocol ErrorHandler where Self: UIViewController & FMIMailerDelegate {
    @objc var mailer: FMIMailer { get }
}

public extension ErrorHandler  {
    func handle(_ error: NSError, retryHandler: @escaping (() -> Void)) {
        handle(error, errorHandler: self, retryHandler: retryHandler)
    }
}
