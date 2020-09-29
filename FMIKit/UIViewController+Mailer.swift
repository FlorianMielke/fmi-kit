extension UIViewController: MailControllerDelegate {
    @objc public var mailer: MailController {
        return .shared
    }
}
