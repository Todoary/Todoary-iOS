//
//  LoginViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/01.
//


import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    
    //MARK: - UIComponenets
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }
    
    let idTf = UITextField().then{
        $0.placeholder = "가입하신 이메일을 입력해주세요"
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .buttonColor
    }


    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }

    let pwTf = UITextField().then{
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.isSecureTextEntry = true
        $0.font = UIFont.nbFont(type: .body2)
    }

    let pwBorderLine = UIView().then{
        $0.backgroundColor = .buttonColor
    }

    let autoLoginTitle = UILabel().then{
        $0.textAlignment = .center
        $0.text = "자동로그인"
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
        $0.titleLabel?.font = UIFont.nbFont(type: .button2)
        $0.layer.cornerRadius = 51/2
    }
    
    let appleBtn = UIButton().then{
        $0.setImage(UIImage(named: "appleid_button 1"), for: .normal)
        $0.layer.cornerRadius = 51/2
    }
    
    let signUpBtn = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.todoaryGrey, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button2)
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
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.todoaryGrey.cgColor
        $0.layer.cornerRadius = 25/2
        $0.addTarget(self, action: #selector(pwSearchBtnDidTab), for: .touchUpInside)
    }

    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setUpView()
        setUpConstraint()
    }
    
    //MARK: - Actions
    
    @objc func signUpBtnDidTab() {
            
        let signUpViewController = SignUpViewController()
        signUpViewController.modalTransitionStyle = .coverVertical
        signUpViewController.modalPresentationStyle = .fullScreen
        self.present(signUpViewController, animated: true, completion: nil)
        }
    
    @objc func pwSearchBtnDidTab() {
        let pwFindViewController = PwFindViewController()
        navigationController?.pushViewController(pwFindViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
        }
    
    @objc func autoLoginBtnDidTab() {
        if autoLoginBtn.isSelected {
            autoLoginBtn.isSelected = false
        }
        else {
            autoLoginBtn.isSelected = true
        }
    }
    
    @objc func backBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
        }
    
    //MARK: - Helpers

}

