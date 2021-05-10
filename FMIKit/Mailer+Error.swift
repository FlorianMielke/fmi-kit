public extension MailController {
    @objc func mail(error: Error, diagnosticData: String?, emailAddress: String, from viewController: UIViewController, delegate: MailControllerDelegate) {
        let errorMessage = FMIKitFactory.createErrorMessage(forError: error, diagnosticData: diagnosticData, bundle: Bundle.main, emailAddress: emailAddress)
        mail(errorMessage, from: viewController, delegate: delegate)
    }
}
