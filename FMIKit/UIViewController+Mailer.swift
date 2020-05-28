extension UIViewController: MailerDelegate {
    @objc public var mailer: Mailer {
        return .shared
    }
}
