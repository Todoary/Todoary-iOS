//
//  LoginView.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/01.
//

import UIKit
import AuthenticationServices

class LoginView: BaseView{
    
    private let isSmallDevice = Const.Device.isSmallDevice
    
    //MARK: - UIComponenets
    
    let logo = UIImageView().then{
        $0.image = UIImage(named: "login_logo")
        $0.contentMode = .scaleAspectFill
    }
    
    let comment = UIImageView().then{
        $0.image = UIImage(named: "login_comment")
        $0.contentMode = .center
        
    }
    
    let picture = UIImageView().then{
        $0.image = UIImage(named: "loginPic")
        $0.contentMode = .center
    }
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        let font: CGFloat = Const.Device.isSmallDevice ? 13 : 16
        $0.font = UIFont.nbFont(ofSize: font, weight: .bold)
    }
    
    let idTextField = UITextField().then{
        $0.placeholder = "가입하신 이메일을 입력해주세요"
        let font: CGFloat = Const.Device.isSmallDevice ? 11 : 14
        $0.font = UIFont.nbFont(ofSize: font, weight: .semibold)
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
        let font: CGFloat = Const.Device.isSmallDevice ? 13 : 16
        $0.font = UIFont.nbFont(ofSize: font, weight: .bold)
    }

    let pwTextField = UITextField().then{
        $0.placeholder = "비밀번호를 입력해주세요"
        let font: CGFloat = Const.Device.isSmallDevice ? 11 : 14
        $0.font = UIFont.nbFont(ofSize: font, weight: .semibold)
        $0.isSecureTextEntry = true
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
        $0.textColor = .todoaryGrey
        let font: TypoStyle = Const.Device.isSmallDevice ? .semibold11 : .semibold14
        $0.setTypoStyleWithSingleLine(typoStyle: font)
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
        let font: CGFloat = Const.Device.isSmallDevice ? 14 : 20
        $0.titleLabel?.font = UIFont.nbFont(ofSize: font, weight: .semibold)
        let height: CGFloat = Const.Device.isSmallDevice ? 40 : 51
        $0.layer.cornerRadius = height/2
        $0.isEnabled = false
    }
    
    let appleLoginButton = UIButton().then{
        $0.setImage(UIImage(named: "appleid_button 1"), for: .normal)
        $0.contentMode = .scaleToFill
        $0.imageView?.contentMode = .scaleToFill
        let height: CGFloat = Const.Device.isSmallDevice ? 40 : 51
        $0.layer.cornerRadius = height/2
    }
    
    let signUpButton = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.todoaryGrey, for: .normal)
        let font: CGFloat = Const.Device.isSmallDevice ? 14 : 20
        $0.titleLabel?.font = UIFont.nbFont(ofSize: font, weight: .semibold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.buttonColor.cgColor
        let height: CGFloat = Const.Device.isSmallDevice ? 40 : 51
        $0.layer.cornerRadius = height/2
    }
    
    let pwSearchButton = UIButton().then{
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.todoaryGrey, for: .normal)
        let font: TypoStyle = Const.Device.isSmallDevice ? .medium7 : .medium10
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: font)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.todoaryGrey.cgColor
        let height: CGFloat = Const.Device.isSmallDevice ? 20 : 25
        $0.layer.cornerRadius = height/2
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
        
        let borderLineTrailing = isSmallDevice ? 35 : 39
        let textHeight = isSmallDevice ? 18 : 20
        let borderLineTop = isSmallDevice ? 2 : 3
        let textFieldTop = isSmallDevice ? 11 : 16
        let loginButtonTop = isSmallDevice ? 8 : 13

        logo.snp.makeConstraints{ make in
            let logoTop = isSmallDevice ? 60 : 100
            make.top.equalToSuperview().offset(logoTop)
            let logoLeading = isSmallDevice ? 33 : 42
            make.leading.equalToSuperview().offset(logoLeading)
            let logoBottom = isSmallDevice ? 18 : 15
            make.bottom.equalTo(comment.snp.top).offset(-logoBottom)
            let logoWidth = isSmallDevice ? 130 : 167
            make.width.equalTo(logoWidth)
            let logoHeight = isSmallDevice ? 40 : 46
            make.height.equalTo(logoHeight)
        }
        
        comment.snp.makeConstraints{ make in
            let commentTop = isSmallDevice ? 18 : 15
            make.top.equalTo(logo.snp.bottom).offset(commentTop)
            make.bottom.equalTo(picture.snp.top)
            let commentLeading = isSmallDevice ? 33 : 46
            make.leading.equalToSuperview().offset(commentLeading)
            let commentWidth = isSmallDevice ? 219 : 221
            make.width.equalTo(commentWidth)
            let commentHeight = isSmallDevice ? 52 : 71
            make.height.equalTo(commentHeight)
        }
        
        picture.snp.makeConstraints{ make in
            let pictureTop = isSmallDevice ? 0 : 0
            make.top.equalTo(comment.snp.bottom).offset(pictureTop)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            let pictureHeight = isSmallDevice ? 89 : 114.06
            make.width.equalToSuperview()
            make.height.equalTo(pictureHeight)
        }
        
        //id
        idTitle.snp.makeConstraints{ make in
            let idTop = isSmallDevice ? 3 : 28.94
            make.top.equalTo(picture.snp.bottom).offset(idTop)
            let idLeading = isSmallDevice ? 35 : 37
            make.leading.equalToSuperview().offset(idLeading)
            make.height.equalTo(textHeight)
        }

        idTextField.snp.makeConstraints{ make in
            make.top.equalTo(idTitle.snp.bottom).offset(textFieldTop)
            make.trailing.equalToSuperview().offset(-borderLineTrailing)
            make.height.equalTo(textHeight)
            make.leading.equalTo(idTitle)
        }
        
        idBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.equalTo(idTextField.snp.leading)
            make.trailing.equalTo(idTextField.snp.trailing)
            make.top.equalTo(idTextField.snp.bottom).offset(borderLineTop)
        }
        
        //password
        pwTitle.snp.makeConstraints{ make in
            let pwTitleTop = isSmallDevice ? 22 : 31
            make.top.equalTo(idBorderLine.snp.bottom).offset(pwTitleTop)
            make.height.equalTo(textHeight)
            make.leading.equalTo(idTitle)
        }
        
        pwTextField.snp.makeConstraints{ make in
            make.top.equalTo(pwTitle.snp.bottom).offset(textFieldTop)
            make.leading.equalTo(idTitle)
            make.height.equalTo(textHeight)
            make.trailing.equalTo(idTextField.snp.trailing)
        }
        
        pwBorderLine.snp.makeConstraints{ make in
            make.trailing.equalTo(idTextField.snp.trailing)
            make.height.equalTo(1)
            make.leading.equalTo(idTextField.snp.leading)
            make.top.equalTo(pwTextField.snp.bottom).offset(borderLineTop)
        }
        
        //autologin
        autoLoginButton.snp.makeConstraints{ make in
            make.trailing.equalTo(pwBorderLine)
            let autoLoginButtonSize = isSmallDevice ? 16 : 22
            make.width.equalTo(autoLoginButtonSize)
            make.height.equalTo(autoLoginButtonSize)
            make.centerY.equalTo(autoLoginTitle).offset(-1)
            
        }
        
        autoLoginTitle.snp.makeConstraints{ make in
            let autoLoginTitleTop = isSmallDevice ? 5 : 10
            make.top.equalTo(pwBorderLine).offset(autoLoginTitleTop)
            make.trailing.equalTo(autoLoginButton.snp.leading).offset(-3)
        }
        
        //button
        loginButton.snp.makeConstraints{ make in
            let loginButtonTop = isSmallDevice ? 43 : 65
            make.top.equalTo(pwBorderLine).offset(loginButtonTop)
            make.leading.trailing.height.equalTo(appleLoginButton)
        }
        
        appleLoginButton.snp.makeConstraints{ make in
            make.top.equalTo(loginButton.snp.bottom).offset(loginButtonTop)
            make.centerX.equalToSuperview()
            let appleLoginButtonLeading = isSmallDevice ? 50 : 33
            make.leading.equalToSuperview().offset(appleLoginButtonLeading)
            let appleLoginButtonHeight = isSmallDevice ? 40 : 51
            make.height.equalTo(appleLoginButtonHeight)
        }
        appleLoginButton.backgroundColor = .black
        signUpButton.snp.makeConstraints{ make in
            make.top.equalTo(appleLoginButton.snp.bottom).offset(loginButtonTop)
            make.leading.trailing.height.equalTo(appleLoginButton)
        }
        
        pwSearchButton.snp.makeConstraints{ make in
            let pwSearchButtonTop = isSmallDevice ? 13.5 : 24
            make.top.equalTo(signUpButton.snp.bottom).offset(pwSearchButtonTop)
            let pwSearchButtonBottom = isSmallDevice ? 15 : 33.67
            make.bottom.equalToSuperview().offset(-pwSearchButtonBottom)
            make.centerX.equalToSuperview()
            let pwSearchButtonCenter = isSmallDevice ? 114.3 : 130
            make.leading.equalToSuperview().offset(pwSearchButtonCenter)
            make.trailing.equalToSuperview().offset(-pwSearchButtonCenter)
            let pwSearchButtonHeight = isSmallDevice ? 20 : 25
            make.height.equalTo(pwSearchButtonHeight)
        }
    }
}

