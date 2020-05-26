public extension FMIMailer {
    @objc func mail(error: Error, presentingViewController viewController: UIViewController & FMIMailerDelegate, emailAddress: String) {
        let errorMessage = FMIKitFactory.createErrorMessage(forError: error, bundle: Bundle.main, emailAddress: emailAddress)
        mail(errorMessage, withPresenting: viewController, delegate: viewController)
    }
}
