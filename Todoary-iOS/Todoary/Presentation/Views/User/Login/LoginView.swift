//
//  LoginView.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/01.
//

import UIKit
import AuthenticationServices

class LoginView: BaseView{
    
    //MARK: - UIComponenets
    
    let logo = UIImageView().then{
        $0.image = UIImage(named: "login_logo")
        $0.contentMode = .scaleAspectFill
    }
    
    let comment = UIImageView().then{
        $0.image = UIImage(named: "login_comment")
        $0.contentMode = .scaleAspectFill
    }
    
    let picture = UIImageView().then{
        $0.image = UIImage(named: "loginPic")
        $0.contentMode = .scaleAspectFill
    }
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(ofSize: 16, weight: .bold)
    }
    
    let idTextField = UITextField().then{
        $0.placeholder = "가입하신 이메일을 입력해주세요"
        $0.textFieldTypeSetting(type: .body1)
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor()
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }


    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(ofSize: 16, weight: .bold)
    }

    let pwTextField = UITextField().then{
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.textFieldTypeSetting(type: .body1)
        $0.isSecureTextEntry = true
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor()
        $0.returnKeyType = .done
        $0.enablesReturnKeyAutomatically = true
    }

    let pwBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let autoLoginTitle = UILabel().then{
        $0.textAlignment = .center
        $0.text = "자동로그인"
        $0.addLetterSpacing(spacing: 0.28)
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let autoLoginButton = UIButton().then{
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.setImage(UIImage(named: "check_box"), for: .selected)
    }
  
    let loginButton = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 20, weight: .semibold)
        $0.layer.cornerRadius = 51/2
        $0.isEnabled = false
    }
    
    let appleLoginButton = UIButton().then{
        $0.setImage(UIImage(named: "appleid_button 1"), for: .normal)
        $0.contentMode = .scaleToFill
        $0.imageView?.contentMode = .scaleToFill
        $0.layer.cornerRadius = 51/2
    }
    
    let signUpButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.todoaryGrey, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 20, weight: .semibold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.buttonColor.cgColor
        $0.layer.cornerRadius = 51/2
    }
    
    let pwSearchButton = UIButton().then{
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.todoaryGrey, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.todoaryGrey.cgColor
        $0.layer.cornerRadius = 25/2
    }
    
    
    override func hierarchy(){
        self.addSubview(logo)
        self.addSubview(comment)
        self.addSubview(picture)
        
        self.addSubview(idTitle)
        self.addSubview(idTextField)
        self.addSubview(idBorderLine)
        
        self.addSubview(pwTitle)
        self.addSubview(pwTextField)
        self.addSubview(pwBorderLine)
        
        self.addSubview(autoLoginButton)
        self.addSubview(autoLoginTitle)
        
        self.addSubview(loginButton)
        self.addSubview(appleLoginButton)
        self.addSubview(signUpButton)
        
        self.addSubview(pwSearchButton)
    
    }
    
    override func layout(){

        logo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(42)
            make.bottom.equalTo(comment.snp.top).offset(-15)
            make.width.equalTo(167)
            make.height.equalTo(46)
        }
        
        comment.snp.makeConstraints{ make in
            make.top.equalTo(logo.snp.bottom).offset(15)
            make.bottom.equalTo(picture.snp.top)
            make.leading.equalToSuperview().offset(46)
            make.width.equalTo(221)
            make.height.equalTo(71)
        }
        
        picture.snp.makeConstraints{ make in
            make.top.equalTo(comment.snp.bottom)
            make.bottom.equalTo(idTitle.snp.top).offset(-28.94)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(114.06)
        }
        
        //id
        idTitle.snp.makeConstraints{ make in
            make.top.equalTo(picture.snp.bottom).offset(28.94)
            make.leading.equalToSuperview().offset(37)
            make.height.equalTo(20)
        }

        idTextField.snp.makeConstraints{ make in
            make.top.equalTo(idTitle.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-39)
            make.height.equalTo(20)
            make.leading.equalTo(idTitle)
        }
        
        idBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.equalTo(idTextField.snp.leading)
            make.trailing.equalTo(idTextField.snp.trailing)
            make.top.equalTo(idTextField.snp.bottom).offset(3)
        }
        
        //password
        pwTitle.snp.makeConstraints{ make in
            make.top.equalTo(idBorderLine.snp.bottom).offset(31)
            make.height.equalTo(20)
            make.leading.equalTo(idTitle)
        }
        
        pwTextField.snp.makeConstraints{ make in
            make.top.equalTo(pwTitle.snp.bottom).offset(16)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.trailing.equalTo(idTextField.snp.trailing)
        }
        
        pwBorderLine.snp.makeConstraints{ make in
            make.trailing.equalTo(idTextField.snp.trailing)
            make.height.equalTo(1)
            make.leading.equalTo(idTextField.snp.leading)
            make.top.equalTo(pwTextField.snp.bottom).offset(3)
        }
        
        //autologin
        autoLoginButton.snp.makeConstraints{ make in
            make.trailing.equalTo(pwBorderLine)
            make.width.equalTo(22)
            make.height.equalTo(22)
            make.centerY.equalTo(autoLoginTitle).offset(-1)
            
        }
        
        autoLoginTitle.snp.makeConstraints{ make in
            make.top.equalTo(pwBorderLine).offset(10)
            make.trailing.equalTo(autoLoginButton.snp.leading).offset(-3)
        }
        
        //button
        loginButton.snp.makeConstraints{ make in
            make.top.equalTo(pwBorderLine).offset(65)
            make.leading.trailing.height.equalTo(appleLoginButton)
        }
        
        appleLoginButton.snp.makeConstraints{ make in
            make.top.equalTo(loginButton.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(33)
            make.height.equalTo(51)
        }
        appleLoginButton.backgroundColor = .black
        signUpButton.snp.makeConstraints{ make in
            make.top.equalTo(appleLoginButton.snp.bottom).offset(13)
            make.leading.trailing.height.equalTo(appleLoginButton)
        }
        
        pwSearchButton.snp.makeConstraints{ make in
            make.top.equalTo(signUpButton.snp.bottom).offset(24)
            make.bottom.equalToSuperview().offset(-33.67)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(130)
            make.trailing.equalToSuperview().offset(-130)
            make.height.equalTo(25)
        }
    }
}

