//
//  PwFindViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/02.
//

import UIKit
import SnapKit
import Then

class PwFindViewController: BaseViewController, UITextFieldDelegate {
    //MARK: - Properties
    
    var password: String = ""
    var email: String = ""
    var certification: String = ""
    
    var emailCheck = false{
        didSet {//프로퍼티 옵저버
            self.validateUserInput()
        }
    }
    var isValidPw = false {
        didSet {//프로퍼티 옵저버
            self.validateUserInput()
        }
    }
    
    var isValidPwCheck = false {
        didSet {//프로퍼티 옵저버
            self.validateUserInput()
        }
    }
    
    var isCertification = false {
        didSet {//프로퍼티 옵저버
            self.validateUserInput()
        }
    }
    
    let mainView = PwFindView()
    
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
    }
    
    override func style(){
        super.style()
        navigationTitle.text = "비밀번호 재설정"
    }
    
    override func layout(){
        
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        mainView.idTf.delegate = self
        mainView.certificationTf.delegate = self
        mainView.pwTf.delegate = self
        mainView.pwCertificationTf.delegate = self
        
        mainView.idCertificationBtn.addTarget(self, action: #selector(idCertificationBtnDidTap), for: .touchUpInside)
        mainView.certificationOkBtn.addTarget(self, action: #selector(certificationOkBtnDidTap), for: .touchUpInside)
        mainView.confirmBtn.addTarget(self, action: #selector(passWordChangeBtnDidTap), for: .touchUpInside)
        
        mainView.pwTf.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
        mainView.pwCertificationTf.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
        
    }
    
    //MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    @objc func backBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
        }
    
    @objc func tfDidChange(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender{
        case mainView.idTf:
            self.email = text
        case mainView.certificationTf:
            self.certification = text
        case mainView.pwTf:
            mainView.pwNoticeLb.isHidden = false
            self.isValidPw = text.isValidPw()
            self.password = text
            if isValidPw{
                mainView.pwNoticeLb.isHidden = true
                }
            else {
                mainView.pwNoticeLb.isHidden = false
            }
        case mainView.pwCertificationTf:
            mainView.pwCertificationNoticeLb.isHidden = false
            if text == self.password {
                isValidPwCheck = true
                mainView.pwCertificationNoticeLb.isHidden = true
            }else{
                isValidPwCheck = false
                mainView.pwCertificationNoticeLb.isHidden = false
            }
        default:
            fatalError("Missing TextField...")
        }
    }
    

    @objc func idCertificationBtnDidTap() {
        self.email = mainView.idTf.text!
        EmailCheckDataManager().emailCheckDataManager(self, email: self.email)
        print(self.email)
        print("버튼")
    }
    
    @objc func passWordChangeBtnDidTap(){
        
        let pwInput = PwFindInput(email:mainView.idTf.text!, newPassword: self.password)
        
        PwFindDataManager().pwFindDataManager(self, pwInput)

    }
    
    @objc func certificationOkBtnDidTap(){
        self.certification = mainView.certificationTf.text!
        if self.certification == UserDefaults.standard.string(forKey: "key"){
            isCertification = true
        }else{
            isCertification = false
        }
        
        let alertTitle : String!
        
        if isCertification{
            alertTitle = "인증이 완료되었습니다."
        }else{
            alertTitle = "인증코드가 일치하지 않습니다."
        }
        
        let alert = ConfirmAlertViewController(title: alertTitle)
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
        
    }
    
    //MARK: - Helpers
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mainView.idTf {
            mainView.certificationTf.becomeFirstResponder()
        } else if textField == mainView.certificationTf {
                mainView.pwTf.becomeFirstResponder()
        }else if textField == mainView.pwTf {
                mainView.pwCertificationTf.becomeFirstResponder()
            }else if textField == mainView.pwCertificationTf {
                mainView.pwCertificationTf.resignFirstResponder()
            }
            return true
        }
    
    func validateUserInput(){
        if isValidPw
            && isValidPwCheck
            && emailCheck
            && isCertification{
            mainView.confirmBtn.isEnabled = true
        }else{
            mainView.confirmBtn.isEnabled = false
        }
    }
    

    func checkEmail(_ code: Int){
        
        if(code == 1000) { //사용가능 이메일 점검 조건문 추가
            
            emailCheck = true
            
            mainView.idNoticeLb.text = "*유효한 이메일입니다."
            mainView.idNoticeLb.textColor = .todoaryGrey
        
            MailSender.shared.sendEmail(email: self.email, viewController: self)
            
        }else if(code == 2017){
            mainView.idNoticeLb.text = "*유효하지 않은 이메일입니다. 다시 입력해 주세요."
            mainView.idNoticeLb.textColor = .noticeRed
            emailCheck = false
        }else{
            emailCheck = false

        }
    }
}

//정규표현식
extension String {
    func isValidPw() -> Bool {
        //영어,숫자 8자 이상일때 -> True
        let pwRegEx = "^(?=.*[a-z])[A-Za-z\\d$@$!%*?&]{8,}"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", pwRegEx)
        return predicate.evaluate(with: self)
    }
}
