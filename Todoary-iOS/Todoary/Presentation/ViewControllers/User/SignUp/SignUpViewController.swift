//
//  SignUpViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/01.
//

import UIKit
import SnapKit
import Then

class SignUpViewController: BaseViewController{
    
    enum InvalidCode: Int{
        case duplicateEmail = 2017
        case quitEmail = 2020
        case duplicateNickname = 2032
        case `default`
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }
    
    override func style() {
        super.style()
        navigationTitle.text = "회원가입"
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
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewDidTapped)))
        
        mainView.idCertificationButton.addTarget(self, action: #selector(certificationBtnDidClicked(_:)), for: .touchUpInside)
        mainView.certificationOkButton.addTarget(self, action: #selector(certificationOKBtnDidClicked(_:)), for: .touchUpInside)
        mainView.nextButton.addTarget(self, action: #selector(requestSignUp), for: .touchUpInside)
    }
    
    override func keyboardWillAppear(noti: NSNotification) {
        
        if(!(mainView.nameTextField.isFirstResponder || mainView.nicknameTextField.isFirstResponder)){
            return
        }
           
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let moveHeight = keyboardRectangle.height - 25
            UIView.animate(
                withDuration: 0.3
                , animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -moveHeight)
                }
            )
        }
    }
    
    private func addActionToTextFieldByCase(){
        
        [mainView.idTextField, mainView.certificationTextField, mainView.pwCertificationTextField].forEach{ each in
            each.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
        }
        
        [mainView.pwTextField, mainView.nameTextField, mainView.nicknameTextField].forEach{ each in
            each.addTarget(self, action: #selector(textFieldDidEditingEnd(_:)), for: .editingDidEnd)
        }
        
        mainView.nicknameTextField.addTarget(self, action: #selector(initNicknameCanUseLabel), for: .editingDidBegin)
    }
    
    private func setTextFieldDelegate(){
        [mainView.idTextField, mainView.certificationTextField, mainView.pwTextField, mainView.nameTextField, mainView.nicknameTextField].forEach{
            $0.delegate = self
        }
    }
    
    //MARK: - Helper

    private func validateUserInput(){
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
    @objc private func initNicknameCanUseLabel(){
        mainView.nicknameCanUseLabel.isHidden = false
        mainView.nicknameCanUseLabel.text = "*10자 이하의 한글,영어,숫자로만 가능합니다."
    }
    
    @objc private func textFieldDidEditingChanged(_ sender: UITextField){
        
        let text = sender.text ?? ""
        
        switch sender {
        case mainView.idTextField:
            isValidEmail = text.isValidEmail()
            email = text
            return
            
        case mainView.certificationTextField:
            isValidCertiCode = (text == UserManager.emailCertificationCode)
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
        mainView.idCertificationButton.isEnabled = false
        mainView.idCanUseLabel.isHidden = false

        if(isValidEmail){
            requestGetEmailDuplicate()
        }else{
            mainView.idCanUseLabel.text = "*이메일 형식이 올바르지 않습니다."
            mainView.idCanUseLabel.textColor = .noticeRed
        }
    }
    
    @objc func certificationOKBtnDidClicked(_ sender: UIButton){
        let alertTitle: String = isValidCertiCode ? "인증이 완료되었습니다." : "인증코드가 일치하지 않습니다."
        ConfirmAlertViewController(title: alertTitle).show(in: self)
    }
    
    //MARK: - API
    
    private func getInvalidationType(code: Int) -> InvalidCode{
        return InvalidCode(rawValue: code) ?? .default
    }
    
    private func requestGetEmailDuplicate(){

        AccountService.shared.checkUserEmailDuplicate(email: self.email){ [self] result in
            switch result{
            case .success:
                print("LOG: SUCCESS requestGetEmailDuplicate", result)
                view.endEditing(true)
                mainView.idCanUseLabel.text = "*사용 가능한 이메일입니다."
                mainView.idCanUseLabel.textColor = .todoaryGrey
                MailSender.shared.sendEmail(email: self.email, viewController: self)
                break
            case .invalidSuccess(let code):
                print("LOG: invalidSuccess requestGetEmailDuplicate", result, code)
                
                switch getInvalidationType(code: code){
                case .duplicateEmail:
                    mainView.idCanUseLabel.do{
                        $0.isHidden = false
                        $0.text = "*중복된 이메일입니다."
                        $0.textColor = .noticeRed
                    }
                    isValidEmail = false
                    break
                case .quitEmail:
                    let alert = CancelReverseMessageAlertViewController(title: "1달 이내에 탈퇴한 계정입니다.\n해당 이메일로 새로\n회원가입 하시겠습니까?",
                                                                 message: "새로 회원가입하면 기존의 데이터는 삭제됩니다.").show(in: self)
                    alert.alertHandler = {
                        guard let root = self.navigationController?.viewControllers.first else { return }
                        self.navigationController?.popToRootViewController(animated: true){
                                ConfirmAlertViewController(title: "계정을 복구 하시려면\n다시 로그인해 주세요.").show(in: root)
                            }
                        }
                    break
                default:
                    break
                }
                break
            default:
                print("LOG: fail requestGetEmailDuplicate", result)
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
        mainView.idCertificationButton.isEnabled = true
    }
    
    @objc private func requestSignUp(){
        
        print("LOG: requestSignUp button did tapped")
        mainView.nextButton.isEnabled = false
        let parameter = SignUpRequestModel(email: email,
                                           name: name,
                                           nickname: nickname,
                                           password: passwd,
                                           isTermsEnable: isMarketingAgree)
        
        AccountService.shared.generateAccount(request: parameter){ [self] result in
            switch result{
            case .success:
                let alert = ConfirmMessageAlertViewController(title: "회원가입을 축하합니다!",
                                                              message: "이제 Todoary 서비스를 자유롭게 이용해보세요.").show(in: self)
                alert.alertHandler = {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                UserManager.isFirstTime = false
                UserManager.defaultImg = true
                break
            case .invalidSuccess(let code):
                print("LOG: FAIL SIGNUP",result, code)
                switch getInvalidationType(code: code){
                case .duplicateNickname:
                    mainView.nextButton.isEnabled = false
                    mainView.nicknameCanUseLabel.isHidden = false
                    mainView.nicknameCanUseLabel.text = "중복된 닉네임입니다."
                    break
                default:
                    mainView.nextButton.isEnabled = true
                    DataBaseErrorAlert.show(in: self)
                    break
                }
                break
            default:
                print("LOG: FAIL SIGNUP",result)
                mainView.nextButton.isEnabled = true
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
}

//MARK: - Keyboard
extension SignUpViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == mainView.pwCertificationTextField {
            return false
        }
        
        if textField == mainView.idTextField {
            mainView.certificationTextField.becomeFirstResponder()
        }else if textField == mainView.certificationTextField {
            mainView.pwTextField.becomeFirstResponder()
        }else if textField == mainView.pwTextField {
            mainView.pwCertificationTextField.becomeFirstResponder()
        }else if textField == mainView.nameTextField {
            mainView.nicknameTextField.becomeFirstResponder()
        }else if textField == mainView.nicknameTextField {
            mainView.nicknameTextField.resignFirstResponder()
        }
        return true
    }
}

extension UINavigationController{
    
    func popToRootViewController(animated: Bool, completion: @escaping () -> Void) {
        
        popToRootViewController(animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
