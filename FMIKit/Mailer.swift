import MessageUI

@objc public class Mailer: NSObject {
    @objc public static let shared = Mailer()
    
    private var delegate: MailerDelegate?
    private var composer: MFMailComposeViewController?
    
    @objc public var canMail: Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    @objc public func mail(_ message: FMIMessage, delegate: MailerDelegate) {
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
        delegate.present(composer!, animated: true, completion: nil)
    }
    
}

extension Mailer: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            self.delegate?.mailerDidFinishSending(self)
        }
    }
}

@objc public protocol MailerDelegate where Self: UIViewController {
    @objc optional func mailerDidFinishSending(_ mailer: Mailer)
}

extension MailerDelegate {
    public func mailerDidFinishSending(_ mailer: Mailer) {
        
    }
}
