//
//  MailSender.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/12.
//

import skpsmtpmessage
import UIKit

class MailSender: NSObject, SKPSMTPMessageDelegate {
    static let shared = MailSender()
    
    let TODOARY_EMAIL: String = Bundle.main.infoDictionary?["TODOARY_EMAIL"] as? String ?? "TODOARY_EMAIL is nil"
    
    let TODOARY_PW: String = Bundle.main.infoDictionary?["TODOARY_PW"] as? String ?? "TODOARY_PW is nil"
    
    let TODOARY_CODE_EMAIL: String = Bundle.main.infoDictionary?["TODOARY_CODE_EMAIL"] as? String ?? "TODOARY_CODE_EMAIL is nil"
    
    let YERI_MAIL: String = Bundle.main.infoDictionary?["YERI_MAIL"] as? String ?? "YERI_MAIL is nil"
    
    var random_num = Int.random(in: 1000...9999)
    
    var viewController: UIViewController!
    
    func randomGenerate() {
        UserManager.emailCertificationCode = String(random_num)
    }

    func sendEmail(email: String, viewController: UIViewController) {
        LoadingHUD.show(backgroundColor: .popUpBackgroundColor)
        self.viewController = viewController
        
        let message = SKPSMTPMessage()
        message.relayHost = "smtp.gmail.com"
        message.login = TODOARY_EMAIL
        message.pass = TODOARY_PW
        message.requiresAuth = true
        message.wantsSecure = true
        message.relayPorts = [587]
        message.fromEmail = TODOARY_CODE_EMAIL
        message.toEmail = email
        message.subject = "Todoary CODE"
        let messagePart = [kSKPSMTPPartContentTypeKey: "text/plain; charset=UTF-8", kSKPSMTPPartMessageKey: "인증번호 [\(random_num)]을 입력해 주세요."]
        message.parts = [messagePart]
        message.delegate = self
        message.send()
        
        randomGenerate()
    }

    func messageSent(_ message: SKPSMTPMessage!) {
        
        print("Successfully sent email!")
        LoadingHUD.hide()
        
        let alert = ConfirmAlertViewController(title: "인증코드가 메일로 발송되었습니다.")
        alert.modalPresentationStyle = .overFullScreen
        self.viewController.present(alert, animated: false, completion: nil)
    }

    func messageFailed(_ message: SKPSMTPMessage!, error: Error!) {
        print("Sending email failed!")
        
        let alert = ConfirmAlertViewController(title: "인증코드 메일 발송을 실패했습니다.")
        alert.modalPresentationStyle = .overFullScreen
        self.viewController.present(alert, animated: false, completion: nil)
    }
}
