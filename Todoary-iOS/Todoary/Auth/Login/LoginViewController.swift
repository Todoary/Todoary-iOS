//
//  LoginViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/01.
//


import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var validateAutoLogin = false
    
    //MARK: - UIComponenets
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .header)
        $0.font = UIFont.nbFont(type: .subtitle)
        $0.labelTypeSetting(type: .tableCell)
    }
    
    let idTf = UITextField().then{
        $0.placeholder = "가입하신 이메일을 입력해주세요"
        $0.textFieldTypeSetting(type: .body1)
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor()
        $0.returnKeyType = UIReturnKeyType.join
        $0.enablesReturnKeyAutomatically = true
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .buttonColor
    }


    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
        $0.labelTypeSetting(type: .tableCell)
    }

    let pwTf = UITextField().then{
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.textFieldTypeSetting(type: .body1)
        $0.isSecureTextEntry = true
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor()
        $0.returnKeyType = UIReturnKeyType.join
        $0.enablesReturnKeyAutomatically = true
    }

    let pwBorderLine = UIView().then{
        $0.backgroundColor = .buttonColor
    }

    let autoLoginTitle = UILabel().then{
        $0.textAlignment = .center
        $0.text = "자동로그인"
        $0.addLetterSpacing(spacing: 0.28)
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let autoLoginBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.addTarget(self, action: #selector(autoLoginBtnDidTab), for: .touchUpInside)
    }
  
    let loginBtn = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont.nbFont(type: .button2)
        $0.layer.cornerRadius = 51/2
        $0.addTarget(self, action: #selector(loginBtnDidTab), for: .touchUpInside)
    }
    
    let appleBtn = UIButton().then{
        $0.setImage(UIImage(named: "appleid_button 1"), for: .normal)
        $0.layer.cornerRadius = 51/2
        $0.addTarget(self, action: #selector(appleBtnDidTab), for: .touchUpInside)
    }
    
    let signUpBtn = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.todoaryGrey, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button2)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.buttonColor.cgColor
        $0.layer.cornerRadius = 51/2
        $0.addTarget(self, action: #selector(signUpBtnDidTab), for: .touchUpInside)
    }
    
    let pwSearchBtn = UIButton().then{
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.todoaryGrey, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.todoaryGrey.cgColor
        $0.layer.cornerRadius = 25/2
        $0.addTarget(self, action: #selector(pwSearchBtnDidTab), for: .touchUpInside)
    }

    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.idTf.delegate = self
        self.pwTf.delegate = self

        setUpView()
        setUpConstraint()
        setupData()
        setKeyboardObserver()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 1){
            self.view.window?.frame.origin.y = 0
        }
    }

    //MARK: - Actions
    
        
    
    @objc func signUpBtnDidTab() {
        let vc = AgreementViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    @objc func pwSearchBtnDidTab() {
        
        let pwFindViewController = PwFindViewController()
        navigationController?.pushViewController(pwFindViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
                }
    
    @objc func autoLoginBtnDidTab() {
        if autoLoginBtn.isSelected {
            autoLoginBtn.isSelected = false
            validateAutoLogin = false
        }
        else {
            autoLoginBtn.isSelected = true
            validateAutoLogin = true
        }
    }
    
    @objc func loginBtnDidTab() {
        if validateAutoLogin == false {
            let loginInput = LoginInput(email: idTf.text, password: pwTf.text)
            LoginDataManager().loginDataManager(self,loginInput)
        } else {
            // 자동로그인을 눌렀을 때
            let autoLoginInput = AutoLoginInput(email: idTf.text, password: pwTf.text)
            AutoLoginDataManager() .autologin(self,autoLoginInput)
        }
      
    }
    
    @objc func appleBtnDidTab() {
        let todoSettingViewController = TodoSettingViewController()
        self.navigationController?.pushViewController(todoSettingViewController, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
        
        
    
    //MARK: - Helpers
    
    private func setupData() {
        if (UserDefaults.standard.string(forKey: "refreshToken") != nil){
            let authJwt = AuthJwtInput(refreshToken: UserDefaults.standard.string(forKey: "refreshToken")!)
            AuthJwtDataManager().authJwtDataManager(self,authJwt)
        }else {
            print("refresh토큰 없음-자동로그인 아님")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTf {
                pwTf.becomeFirstResponder()
            } else {
                pwTf.resignFirstResponder()
            }
            return true
        }

}

