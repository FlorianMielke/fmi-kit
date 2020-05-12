extension FMIMailer {
    public func mail<Error>(error: Error, presentingViewController viewController: UIViewController & FMIMailerDelegate, emailAddress: String) where Error: LocalizedError {
        let errorMessage = FMIKitFactory.createErrorMessage(forError: error, bundle: Bundle.main, emailAddress: emailAddress)
        mail(errorMessage, withPresenting: viewController, delegate: viewController)
    }
}
