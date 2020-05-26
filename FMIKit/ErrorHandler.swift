@objc public protocol ErrorHandler where Self: UIViewController & FMIMailerDelegate {
    @objc var mailer: FMIMailer { get }
}
