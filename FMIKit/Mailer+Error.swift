public extension Mailer {
    @objc func mail(error: Error, from viewController: UIViewController, delegate: MailerDelegate, emailAddress: String) {
        let errorMessage = FMIKitFactory.createErrorMessage(forError: error, bundle: Bundle.main, emailAddress: emailAddress)
        mail(errorMessage, from: viewController, delegate: delegate)
    }
}