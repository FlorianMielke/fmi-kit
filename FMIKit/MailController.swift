import MessageUI

@objc public class MailController: NSObject {
    @objc public static let shared = MailController()
    
    private weak var delegate: MailControllerDelegate?
    private var composer: MFMailComposeViewController?
    
    @objc public var canMail: Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    @objc public func mail(_ message: FMIMessage, from viewController: UIViewController, delegate: MailControllerDelegate) {
        guard canMail else { return }
        self.delegate = delegate
        composer = MFMailComposeViewController()
        composer?.mailComposeDelegate = self
        composer?.setToRecipients(message.toRecipients)
        composer?.setSubject(message.subject)
        composer?.setMessageBody(message.messageBody, isHTML: false)
        message.attachments.forEach { attachment in
            composer?.addAttachmentData(attachment.dataRepresentation, mimeType: attachment.mimeType, fileName: attachment.fileName)
        }
        viewController.present(composer!, animated: true, completion: nil)
    }
}

extension MailController: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            self.delegate?.mailerDidFinishSending?(self)
        }
    }
}

@objc public protocol MailControllerDelegate: AnyObject {
    @objc optional func mailerDidFinishSending(_ mailer: MailController)
}
