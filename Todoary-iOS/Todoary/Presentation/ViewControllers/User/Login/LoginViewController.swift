//
//  LoginViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/01.
//


import UIKit
import SnapKit
import Then
import AuthenticationServices
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    let mainView = LoginView()
    
    var validateAutoLogin = false
    
    var loginData: LoginResultModel!
    
    var id :String = ""
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        style()
        layout()
        initialize()
        
        //로그인VC 접근시 기존 스택VC들 제거
        let endIndex = (self.navigationController?.viewControllers.endIndex)!
        
        self.navigationController?.viewControllers.removeSubrange(0..<endIndex - 1)
        
    }
    
    //MARK: - BaseProtocol
    
    func style() {
    }
    
    func layout() {
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func initialize() {
        addActionToTextFieldByCase()
        setTextFieldDelegate()
        
        mainView.autoLoginButton.addTarget(self, action: #selector(autoLoginButtonDidTab), for: .touchUpInside)
        mainView.loginButton.addTarget(self, action: #selector(loginButtonDidTab), for: .touchUpInside)
        mainView.appleLoginButton.addTarget(self, action: #selector(appleButtonDidTab), for: .touchUpInside)
        mainView.signUpButton.addTarget(self, action: #selector(signUpButtonDidTab), for: .touchUpInside)
        mainView.pwSearchButton.addTarget(self, action: #selector(pwSearchButtonDidTab), for: .touchUpInside)
    }
    
    func addActionToTextFieldByCase(){
        
        let tfChangedArray = [mainView.idTextField, mainView.pwTextField]
        
        tfChangedArray.forEach{ each in
            each.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    func setTextFieldDelegate(){
        let textFields = [mainView.idTextField, mainView.pwTextField]
        
        textFields.forEach{ each in
            each.delegate = self
        }
    }

    //MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    
    @objc func textFieldDidChange() {
        if mainView.idTextField.text != "" && mainView.pwTextField.text != ""{
            mainView.loginButton.backgroundColor = .buttonColor
            mainView.loginButton.isEnabled = true
        }else{
            mainView.loginButton.backgroundColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
            mainView.loginButton.isEnabled = false
        }
    }
    
    @objc func signUpButtonDidTab() {
        let vc = AgreementViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    @objc func pwSearchButtonDidTab() {
        
        let passwordFindViewController = PasswordFindViewController()
        navigationController?.pushViewController(passwordFindViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
                }
    
    @objc func autoLoginButtonDidTab() {
        if mainView.autoLoginButton.isSelected {
            mainView.autoLoginButton.isSelected = false
            validateAutoLogin = false
        }
        else {
            mainView.autoLoginButton.isSelected = true
            validateAutoLogin = true
        }
    }
    
    @objc func loginButtonDidTab() {
        if validateAutoLogin == false {
            id = mainView.idTextField.text ?? "id"
            let loginRequest = LoginRequestModel(email: mainView.idTextField.text, password: mainView.pwTextField.text)
            requestLogin(parameter: loginRequest)
            
        } else {
            // 자동로그인을 눌렀을 때
            id = mainView.idTextField.text ?? "id"
            let autoLoginRequest = LoginRequestModel(email: mainView.idTextField.text, password: mainView.pwTextField.text)
            requestAutoLogin(parameter: autoLoginRequest)
        }
        
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
      
    }
    
    @objc func appleButtonDidTab() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
    
    //MARk: - API
    
    private func requestLogin(parameter: LoginRequestModel){
        AccountService.shared.login(request: parameter){ result in
            switch result {
            case .success(let data):
                print("로그: [requestLogin] success")
                UserManager.isFirstTime = false
                
//                Analytics.setUserID("userID = \(12)")
//                Analytics.setUserProperty("ko", forName: "country")
//                Analytics.logEvent(event, parameters: parameters)
                
                let data = data as? LoginResultModel
                UserDefaults.standard.set(data?.token?.accessToken , forKey: "accessToken")
                if UserDefaults.standard.bool(forKey: "appPasswordCheck") == true {
                    let appPasswordViewController = AppPasswordViewController()
                    self.navigationController?.pushViewController(appPasswordViewController, animated: true)
                    self.navigationController?.isNavigationBarHidden = true
                }else {
                    let homeViewController = HomeViewController()
                    self.navigationController?.pushViewController(homeViewController, animated: true)
                    self.navigationController?.isNavigationBarHidden = true
                }
                break
            case .invalidSuccess(let code):
                switch code{
                case 2011:
                    let alert = ConfirmAlertViewController(title: "회원정보가 존재하지 않습니다.")
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: false, completion: nil)
                    break
                case 2012:
                    let alert = ConfirmAlertViewController(title: "회원정보가 존재하지 않습니다.")
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: false, completion: nil)
                    break
                case 2112:
                    let alert = ConfirmAlertViewController(title: "로그인 정보가 일치하지 않습니다.")
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: false, completion: nil)
                    break
                case 2020:
                    let alert = CancelAlertViewController(title: "탈퇴 계정입니다 복구하시겠습니까?").show(in: self)
                    alert.alertHandler = {
                        let restoreRequestModel = RestoreRequestModel(email: self.id, provider: "", providerId: "")
                        self.requestRestoreDeactivateAccount(parameter: restoreRequestModel)
                    }
                    break
                default:
                    print("로그: [requestLogin] fail")
                    DataBaseErrorAlert.show(in: self)
                    break
                }
            default:
                print("로그: [requestLogin] fail")
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    private func requestAutoLogin(parameter: LoginRequestModel){
        AccountService.shared.autoLogin(request: parameter){ result in
            switch result {
            case .success(let data):
                print("로그: [requestAutoLogin] success")
                UserManager.isFirstTime = false
//                let event = "autoLoginSuccess"
//                  let parameters = [
//                    "file": "loginviewcontroller",
//                    "function": "requestAutoLogin"
//                  ]
                
                let data = data as? LoginResultModel
                UserDefaults.standard.set(data?.token?.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(data?.token?.refreshToken, forKey: "refreshToken")
                if UserDefaults.standard.bool(forKey: "appPasswordCheck") == true {
                    let appPasswordViewController = AppPasswordViewController()
                    self.navigationController?.pushViewController(appPasswordViewController, animated: true)
                    self.navigationController?.isNavigationBarHidden = true
                }else {
                    let homeViewController = HomeViewController()
                    self.navigationController?.pushViewController(homeViewController, animated: true)
                    self.navigationController?.isNavigationBarHidden = true
                }
                break
            case .invalidSuccess(let code):
                print("LOG: INVALID SUCCESS LOGIN", result,code)
                switch code{
                case 2011:
                    let alert = ConfirmAlertViewController(title: "회원정보가 존재하지 않습니다.")
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: false, completion: nil)
                    break
                case 2012:
                    let alert = ConfirmAlertViewController(title: "회원정보가 존재하지 않습니다.")
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: false, completion: nil)
                    break
                case 2112:
                    let alert = ConfirmAlertViewController(title: "로그인 정보가 일치하지 않습니다.")
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: false, completion: nil)
                    break
                case 2020:
                    let alert = CancelAlertViewController(title: "탈퇴 계정입니다 복구하시겠습니까?").show(in: self)
                    alert.alertHandler = {
                        let restoreRequestModel = RestoreRequestModel(email: self.id, provider: "", providerId: "")
                        self.requestRestoreDeactivateAccount(parameter: restoreRequestModel)
                    }
                    break
                default:
                    print("로그: [requestLogin] fail", result, code)
                    DataBaseErrorAlert.show(in: self)
                    break
                }
            default:
                print("로그: [requestLogin] fail", result)
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
    func requestRestoreDeactivateAccount(parameter: RestoreRequestModel){
        AccountService.shared.restoreDeactivateAccount(request: parameter){ [self] result in
            switch result{
            case .success:
                print("로그: [requestRestoreDeactivateAccount] success")
                loginButtonDidTab()
                break
            default:
                print("로그: [requestRestoreDeactivateAccount] fail")
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
}


//MARK: - Keyboard

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mainView.idTextField {
            mainView.pwTextField.becomeFirstResponder()
            } else {
                mainView.pwTextField.resignFirstResponder()
                UIView.animate(withDuration: 0.3){
                    self.view.window?.frame.origin.y = 0
                }
            }
            return true
        }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y -= 50
        }
        return true
    }
}

//MARK: - Helpers

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate{
    
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    /*
     email, userName 정보 -> 키체인에 바로 저장
     userIdentifier 정보 -> 프로퍼티에 임시 저장
     이후 회원가입 완료시 userIndentifier 정보도 키체인에 저장
     
     => userIdentifier가 키체인에 있을 경우 유저 정보가 있다는 걸로..
     */
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
            let identityToken = String(data: appleIDCredential.identityToken!, encoding: .ascii)!
            let userIdentifier = appleIDCredential.user
            
            let email: String!
            let userName: String!
            
            if let emailData = appleIDCredential.email, let name =  appleIDCredential.fullName{
                //email 값 nil 아닌 경우 -> 키체인에 값 저장하기
                email = emailData
                userName = "\(name.familyName!)\(name.givenName!)"
                
                KeyChain.create(key: Const.UserDefaults.email, value: email)
                KeyChain.create(key: Const.UserDefaults.userName, value: userName)
            }else{
                //email 값 nil인 경우 -> 키체인에서 값 가져오기
                email = KeyChain.read(key: Const.UserDefaults.email)
                userName = KeyChain.read(key: Const.UserDefaults.userName)
            }
            
            let userInput = AppleSignUpRequestModel(code: authorizationCode!,
                                                    idToken: identityToken,
                                                    name: userName,
                                                    email: email,
                                                    userIdentifier: userIdentifier)
            
            if KeyChain.read(key: Const.UserDefaults.appleRefreshToken) != nil {
                //userIdentifier값 nil이 아닌 경우 -> 로그인 진행
                KeyChain.delete(key: Const.UserDefaults.appleIdentifier)
                KeyChain.delete(key: Const.UserDefaults.appleRefreshToken)
                requestLoginAppleAccount(parameter: userInput)
            }else{
                //userIdentifier값 nil인 경우 -> 회원가입 필요
                let vc = AgreementViewController()
                
                vc.appleUserInfo = userInput
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
    func requestLoginAppleAccount(parameter: AppleSignUpRequestModel){
        AccountService.shared.generateAppleAccount(request: parameter){ result in
            switch result{
            case .success(let data):
                print("LOG: SUCCESS APLLE LOGIN", data)
                UserManager.isFirstTime = false
                UserManager.defaultImg = true
                guard let data = data as? AppleSignUpResultModel else { return }
                KeyChain.create(key: Const.UserDefaults.appleIdentifier, value: parameter.userIdentifier)
                KeyChain.create(key: Const.UserDefaults.appleRefreshToken, value: data.appleRefreshToken)
                
                UserDefaults.standard.set(data.token.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(data.token.refreshToken, forKey: "refreshToken")
                
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
                break
            default:
                print("LOG: FAIL APPLE LOGIN", result)
                DataBaseErrorAlert.show(in: self)
                break
            }
        }
    }
    
}

import Foundation
import Security

class KeyChain {
    // Create
    class func create(key: String, value: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,   // 저장할 Account
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false) as Any   // 저장할 Token
        ]
        SecItemDelete(query)    // Keychain은 Key값에 중복이 생기면, 저장할 수 없기 때문에 먼저 Delete해줌

        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save Token")
    }
    
    // Read
    class func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,  // CFData 타입으로 불러오라는 의미
            kSecMatchLimit: kSecMatchLimitOne       // 중복되는 경우, 하나의 값만 불러오라는 의미
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess {
            if let retrievedData: Data = dataTypeRef as? Data {
                let value = String(data: retrievedData, encoding: String.Encoding.utf8)
                return value
            } else { return nil }
        } else {
            print("failed to loading, status code = \(status)")
            return nil
        }
    }
    
    // Delete
    class func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
}

