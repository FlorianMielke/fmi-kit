public extension UIAlertController {
    @objc convenience init(_ error: NSError, errorHandler: ErrorHandler, emailAddress: String, preferredStyle: UIAlertController.Style = .alert) {
        let message = [error.localizedFailureReason, error.localizedRecoverySuggestion].compactMap { $0 }.joined(separator: "\n\n")
        self.init(title: error.localizedDescription, message: message, preferredStyle: preferredStyle)
        if errorHandler.mailer.canMail() {
            let mailAction = UIAlertAction(title: NSLocalizedString("alert-controller.error.action.contact-support", tableName: "FMIKitLocalizable", bundle: Bundle.fmiKit(), comment: ""), style: .default) { (action) in
                errorHandler.mailer.mail(error: error, presentingViewController: errorHandler, emailAddress: emailAddress)
            }
            addAction(mailAction)
        }
        addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
    }
}
