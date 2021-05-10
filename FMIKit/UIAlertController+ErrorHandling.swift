public extension UIAlertController {
    @objc convenience init(_ error: NSError, diagnosticData: String? = nil, from viewController: UIViewController, emailAddress: String, preferredStyle: UIAlertController.Style = .alert, retryHandler: (() -> Void)?, cancelHandler: (() -> Void)?) {
        self.init(title: error.localizedDescription, message: error.completeMessages, preferredStyle: preferredStyle)
        if let retryHandler = retryHandler {
            addAction(UIAlertAction(title: NSLocalizedString("alert.error.action.retry", tableName: "FMIKitLocalizable", bundle: Bundle.fmiKit(), comment: ""), style: .default, handler: { _ in retryHandler() } ))
        }
        
        if mailer.canMail {
            let mailAction = UIAlertAction(title: NSLocalizedString("alert.error.action.contact-support", tableName: "FMIKitLocalizable", bundle: Bundle.fmiKit(), comment: ""), style: .default) { (action) in
                viewController.mailer.mail(error: error, diagnosticData: diagnosticData, emailAddress: emailAddress, from: viewController, delegate: viewController)
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
        self.init(title: error.localizedDescription, message: error.shortMessaged, preferredStyle: preferredStyle)
        addAction(UIAlertAction(title: NSLocalizedString("OK", tableName: "FMIKitLocalizable", bundle: Bundle.fmiKit(), comment: ""), style: .cancel, handler: nil))
    }
}
