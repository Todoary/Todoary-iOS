//
//  SignUpViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import UIKit
import SnapKit
import Then

class SignUpViewController: BaseViewController, BaseViewControllerProtocol{
    
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
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        style()
        layout()
        initialize()
    }
    
    //MARK: - BaseProtocol
    
    func style() {
        self.navigationTitle.text = "회원가입"
    }
    
    func layout() {
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func initialize() {
        addActionToTextFieldByCase()
        setTextFieldDelegate()
        
        mainView.idCertificationButton.addTarget(self, action: #selector(certificationBtnDidClicked(_:)), for: .touchUpInside)
        mainView.certificationOkButton.addTarget(self, action: #selector(certificationOKBtnDidClicked(_:)), for: .touchUpInside)
        mainView.nextButton.addTarget(self, action: #selector(nextButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    func addActionToTextFieldByCase(){
        
        let tfChangedArray = [mainView.idTextField, mainView.certificationTextField, mainView.pwCertificationTextField]
        
        tfChangedArray.forEach{ each in
            each.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
        }
        
        let tfEditedEndArray = [mainView.pwTextField, mainView.nameTextField, mainView.nicknameTextField]
        
        tfEditedEndArray.forEach{ each in
            each.addTarget(self, action: #selector(textFieldDidEditingEnd(_:)), for: .editingDidEnd)
        }
        
        mainView.nicknameTextField.addTarget(self, action: #selector(initNicknameCanUseLabel), for: .editingDidBegin)
    }
    
    func setTextFieldDelegate(){
        let textFields = [mainView.idTextField, mainView.certificationTextField, mainView.pwTextField, mainView.nameTextField, mainView.nicknameTextField]
        
        textFields.forEach{ each in
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
            
            if (bool){
                mainView.pwIncorrectLabel.isHidden = true
            }else{
                mainView.pwIncorrectLabel.isHidden = false
            }
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
            //이메일 중복 여부 확인
            SignUpDataManager().gets(self, email: self.email)
            print("API - email 중복 검사 요청")

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
        
        let alert = ConfirmAlertViewController(title: alertTitle)
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
    }
    
    @objc func nextButtonDidClicked(_ sender: UIButton){
        let userData = SignUpInput(email: self.email, name: self.name, nickname: self.nickname, password: self.passwd, isTermsEnable: self.isMarketingAgree)
        SignUpDataManager().posts(self, userData)
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

//MARK: - API
extension SignUpViewController{
    
    func checkSignUpResultCode(_ code: Int){
        switch(code){
        case 1000:
            let alert = ConfirmMessageAlertViewController(title: "회원가입을 축하합니다!", message: "이제 Todoary 서비스를 자유롭게 이용해보세요.")
            alert.alertHandler = {
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: false, completion: nil)
            return
        case 2017:
            mainView.nextButton.isEnabled = false
            mainView.idCanUseLabel.isHidden = false
            mainView.idCanUseLabel.text = "중복된 이메일입니다."
            return
        case 2032:
            mainView.nextButton.isEnabled = false
            mainView.nicknameCanUseLabel.isHidden = false
            mainView.nicknameCanUseLabel.text = "중복된 닉네임입니다."
            return
        default:
            print("데이터 베이스 오류")
            mainView.nextButton.isEnabled = false
            //팝업 띄우기
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func checkEmailApiResultCode(_ code: Int){
        
        switch code {
        case 1000:
            
            mainView.idCanUseLabel.text = "*사용 가능한 이메일입니다."
            mainView.idCanUseLabel.textColor = .todoaryGrey
            
            MailSender.shared.sendEmail(email: self.email, viewController: self)
            
            return
            
        case 2017:
            mainView.idCanUseLabel.isHidden = false
            mainView.idCanUseLabel.text = "*중복된 이메일 입니다."
            mainView.idCanUseLabel.textColor = .noticeRed
            isValidEmail = false
            
            return
        default:
            print("데이터베이스 오류")
            let alert = DataBaseErrorAlert()
            self.present(alert, animated: true, completion: nil)
            return
        }
        
    }
}
