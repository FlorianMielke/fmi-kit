public extension UIAlertController {
    @objc convenience init(_ error: NSError, errorHandler: ErrorHandler, emailAddress: String, preferredStyle: UIAlertController.Style = .alert, retryHandler: (() -> Void)?, cancelHandler: (() -> Void)?) {
        let message = [error.localizedFailureReason, error.localizedRecoverySuggestion].compactMap { $0 }.joined(separator: "\n\n")
        self.init(title: error.localizedDescription, message: message, preferredStyle: preferredStyle)
        if let retryHandler = retryHandler {
            addAction(UIAlertAction(title: NSLocalizedString("alert-controller.error.action.retry", tableName: "FMIKitLocalizable", bundle: Bundle.fmiKit(), comment: ""), style: .default, handler: { _ in retryHandler() } ))
        }
        if errorHandler.mailer.canMail() {
            let mailAction = UIAlertAction(title: NSLocalizedString("alert-controller.error.action.contact-support", tableName: "FMIKitLocalizable", bundle: Bundle.fmiKit(), comment: ""), style: .default) { (action) in
                errorHandler.mailer.mail(error: error, presentingViewController: errorHandler, emailAddress: emailAddress)
            }
            addAction(mailAction)
        }
        if let cancelHandler = cancelHandler {
            addAction(UIAlertAction(title: NSLocalizedString("Cancel", tableName: "FMIKitLocalizable", bundle: Bundle.fmiKit(), comment: ""), style: .cancel, handler: { _ in cancelHandler() }))
        } else {
            addAction(UIAlertAction(title: NSLocalizedString("Cancel", tableName: "FMIKitLocalizable", bundle: Bundle.fmiKit(), comment: ""), style: .cancel, handler: nil))
        }
    }
    
    @objc convenience init(_ error: NSError, preferredStyle: UIAlertController.Style = .alert) {
        let message = [error.localizedFailureReason, error.localizedRecoverySuggestion].compactMap { $0 }.joined(separator: "\n\n")
        self.init(title: error.localizedDescription, message: message, preferredStyle: preferredStyle)
        addAction(UIAlertAction(title: NSLocalizedString("OK", tableName: "FMIKitLocalizable", bundle: Bundle.fmiKit(), comment: ""), style: .cancel, handler: nil))
    }
}
