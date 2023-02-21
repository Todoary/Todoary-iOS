//
//  SignUpViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import UIKit
import SnapKit
import Then

//TODO: - HTTP METHOD URL EMAIL_DUPLICATE -> "/auth/email/duplication"으로 변경ㅇ
class SignUpViewController: BaseViewController{
    
    //MARK: - Properties
    
    var email: String = ""
    var certificationCode : String = ""
    var passwd : String = ""
    var passwdCheck : String = ""
    var name : String = ""
    var nickname : String = ""
    
    var isMarketingAgree : Bool! //agreemnetVC에서 마케팅 동의 여부 정보 넘겨받기
    var isValidEmail = false{
        didSet { self.validateUserInput() }
    }
    var isValidCertiCode = false{
        didSet{ self.validateUserInput() }
    }
    var isValidPasswd = false{
        didSet{ self.validateUserInput() }
    }
    var isValidPasswdCheck = false{
        didSet{ self.validateUserInput() }
    }
    var isValidName = false{
        didSet{ self.validateUserInput() }
    }
    var isValidNickname = false{
        didSet{ self.validateUserInput() }
    }
    
    let mainView = SignUpView()
    
    //MARK: - Override
    
    override func style() {
        super.style()
        self.navigationTitle.text = "회원가입"
    }
    
    override func layout() {
        
        super.layout()
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        
        addActionToTextFieldByCase()
        setTextFieldDelegate()
        
        mainView.idCertificationButton.addTarget(self, action: #selector(certificationBtnDidClicked(_:)), for: .touchUpInside)
        mainView.certificationOkButton.addTarget(self, action: #selector(certificationOKBtnDidClicked(_:)), for: .touchUpInside)
        mainView.nextButton.addTarget(self, action: #selector(requestSignUp), for: .touchUpInside)
    }
    
    func addActionToTextFieldByCase(){
        
        [mainView.idTextField, mainView.certificationTextField, mainView.pwCertificationTextField].forEach{ each in
            each.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
        }
        
        [mainView.pwTextField, mainView.nameTextField, mainView.nicknameTextField].forEach{ each in
            each.addTarget(self, action: #selector(textFieldDidEditingEnd(_:)), for: .editingDidEnd)
        }
        
        mainView.nicknameTextField.addTarget(self, action: #selector(initNicknameCanUseLabel), for: .editingDidBegin)
    }
    
    func setTextFieldDelegate(){
        [mainView.idTextField, mainView.certificationTextField, mainView.pwTextField, mainView.nameTextField, mainView.nicknameTextField].forEach{ each in
            each.delegate = self
        }
    }
    
    //MARK: - Helper

    func validateUserInput(){
        if isValidName
            && isValidPasswd
            && isValidNickname
            && isValidCertiCode
            && isValidPasswdCheck {
            mainView.nextButton.isEnabled = true
        }else{
            mainView.nextButton.isEnabled = false
        }
    }
    
    //MARK: - Action
    @objc func initNicknameCanUseLabel(){
        mainView.nicknameCanUseLabel.isHidden = false
        mainView.nicknameCanUseLabel.text = "*10자 이하의 한글,영어,숫자로만 가능합니다."
    }
    
    @objc func textFieldDidEditingChanged(_ sender: UITextField){
        
        let text = sender.text ?? ""
        
        switch sender {
        case mainView.idTextField:
            isValidEmail = text.isValidEmail()
            email = text
            return
            
        case mainView.certificationTextField:
            isValidCertiCode = (text == UserDefaults.standard.string(forKey: "key"))
            return
            
        case mainView.pwCertificationTextField:
            let bool = (sender.text == passwd)
            isValidPasswdCheck = bool
            mainView.pwIncorrectLabel.isHidden = bool ? true : false
            return
            
        default:
            fatalError("Missing Textfield")
        }
    }
    
    @objc func textFieldDidEditingEnd(_ sender : UITextField){
        
        let text = sender.text ?? ""
        
        switch sender{
        case mainView.pwTextField:
            isValidPasswd = text.isValidPassword()
            if(!isValidPasswd){
                mainView.pwCanUseLabel.isHidden = false
            }else{
                mainView.pwCanUseLabel.isHidden = true
            }
            passwd = text
            return
        case mainView.nameTextField:
            isValidName = text.isValidName()
            if(isValidName){
                mainView.nameCanUseLabel.isHidden = true
                name = text
            }else{
                mainView.nameCanUseLabel.isHidden = false
            }
            return
        case mainView.nicknameTextField:
            isValidNickname = text.isValidNickname()
            if(isValidNickname){
                mainView.nicknameCanUseLabel.isHidden = true
                nickname = text
            }else{
                mainView.nicknameCanUseLabel.isHidden = false
            }
            return
        default:
            fatalError("Missing Textfield")
        }
    }
    
    @objc func certificationBtnDidClicked(_ sender: UIButton){
        
        mainView.idCanUseLabel.isHidden = false
        
        if(isValidEmail){
            requestGetEmailDuplicate()
        }else{
            mainView.idCanUseLabel.text = "*이메일 형식이 올바르지 않습니다."
            mainView.idCanUseLabel.textColor = .noticeRed
        }
            
    }
    
    @objc func certificationOKBtnDidClicked(_ sender: UIButton){
        
        let alertTitle : String!
        if isValidCertiCode{
            alertTitle = "인증이 완료되었습니다."
        }else{
            alertTitle = "인증코드가 일치하지 않습니다."
        }
        
        let alert = ConfirmAlertViewController(title: alertTitle).show(in: self)
    }
    
    //MARK: - API
    private func requestGetEmailDuplicate(){
        AccountService.shared.checkUserEmailDuplicate(email: self.email){ result in
            switch result{
            case .success:
                self.mainView.idCanUseLabel.text = "*사용 가능한 이메일입니다."
                self.mainView.idCanUseLabel.textColor = .todoaryGrey
                MailSender.shared.sendEmail(email: self.email, viewController: self)
                break
            case .invalidSuccess(let code):
                if(code == 2017){
                    self.mainView.idCanUseLabel.isHidden = false
                    self.mainView.idCanUseLabel.text = "*중복된 이메일 입니다."
                    self.mainView.idCanUseLabel.textColor = .noticeRed
                    self.isValidEmail = false
                }
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    @objc private func requestSignUp(){
        
        let parameter = SignUpRequestModel(email: email,
                                           name: name,
                                           nickname: nickname,
                                           password: passwd,
                                           isTermsEnable: isMarketingAgree)
        
        AccountService.shared.generateAccount(request: parameter){ result in
            switch result{
            case .success:
                let alert = ConfirmMessageAlertViewController(title: "회원가입을 축하합니다!", message: "이제 Todoary 서비스를 자유롭게 이용해보세요.").show(in: self)
                
                UserDefaults.standard.set("No", forKey: "isFirstTime")
                UserDefaults.standard.set(true, forKey: "defaultImg")
                
                alert.alertHandler = {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                break
            case .invalidSuccess(let code):
                switch code{
                case 2017:
                    self.mainView.nextButton.isEnabled = false
                    self.mainView.idCanUseLabel.isHidden = false
                    self.mainView.idCanUseLabel.text = "중복된 이메일입니다."
                    break
                case 2032:
                    self.mainView.nextButton.isEnabled = false
                    self.mainView.nicknameCanUseLabel.isHidden = false
                    self.mainView.nicknameCanUseLabel.text = "중복된 닉네임입니다."
                    break
                default:
                    self.mainView.nextButton.isEnabled = false
                    DataBaseErrorAlert.show(in: self)
                    break
                }
                break
            default:
                self.mainView.nextButton.isEnabled = false
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
}

//MARK: - Keyboard
extension SignUpViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        let size: CGFloat!
        
        switch textField{
        case mainView.nameTextField:
            size = 80
            break
        case mainView.nicknameTextField:
            size = 200
            break
        default:
            return true
        }
        
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y -= size
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mainView.idTextField {
            mainView.certificationTextField.becomeFirstResponder()
        } else if textField == mainView.certificationTextField {
                mainView.pwTextField.becomeFirstResponder()
        }else if textField == mainView.pwTextField {
                mainView.pwCertificationTextField.becomeFirstResponder()
        }else if textField == mainView.pwCertificationTextField {
                mainView.nameTextField.becomeFirstResponder()
        }else if textField == mainView.nameTextField {
                mainView.nicknameTextField.becomeFirstResponder()
        }else if textField == mainView.nicknameTextField {
                mainView.nicknameTextField.resignFirstResponder()
                UIView.animate(withDuration: 0.3){
                    self.view.window?.frame.origin.y = 0
                }
            }
            return true
        }
}
