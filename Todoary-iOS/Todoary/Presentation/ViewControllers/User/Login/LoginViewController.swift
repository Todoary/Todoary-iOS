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

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    let mainView = LoginView()
    
    var validateAutoLogin = false
    
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
        
        let pwFindViewController = PwFindViewController()
        navigationController?.pushViewController(pwFindViewController, animated: true)
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
            let loginInput = LoginInput(email: mainView.idTextField.text, password: mainView.pwTextField.text)
            LoginDataManager().loginDataManager(self,loginInput)
        } else {
            // 자동로그인을 눌렀을 때
            let autoLoginInput = AutoLoginInput(email: mainView.idTextField.text, password: mainView.pwTextField.text)
            AutoLoginDataManager().autologin(self,autoLoginInput)
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
            
            let userInput = AppleLoginInput(code: authorizationCode!, idToken: identityToken, name: userName, email: email, userIdentifier: userIdentifier)
            
            if KeyChain.read(key: Const.UserDefaults.appleRefreshToken) != nil {
                //userIdentifier값 nil이 아닌 경우 -> 로그인 진행
                KeyChain.delete(key: Const.UserDefaults.appleIdentifier)
                KeyChain.delete(key: Const.UserDefaults.appleRefreshToken)
                
                AppleLoginDataManager().post(self, parameter: userInput)
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

