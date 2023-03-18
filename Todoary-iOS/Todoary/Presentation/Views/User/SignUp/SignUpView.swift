//
//  SignUpView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/27.
//

import UIKit

class SignUpView: BaseView {
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .subtitle)
    }
    
    let idTextField = UITextField().then{
        $0.placeholder = "이메일을 입력해주세요"
        $0.textFieldTypeSetting()
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let idCertificationButton = UIButton().then{
        $0.setTitle("인증하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.buttonTypeSetting(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
    }
    
    let idCanUseLabel = UILabel().then{
        $0.labelTypeSetting(type: .sub1)
        $0.isHidden = true
    }
    
    //인증코드
    let certificationTitle = UILabel().then{
        $0.text = "인증코드 입력"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .subtitle)
        
    }

    let certificationTextField = UITextField().then{
        $0.textFieldTypeSetting()
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let certificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let certificationOkButton = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.buttonTypeSetting(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
    }

    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .subtitle)
    }

    let pwTextField = UITextField().then{
        $0.placeholder = "영문, 숫자 포함 8자리 이상"
        $0.textFieldTypeSetting()
        $0.isSecureTextEntry = true
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let pwBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let pwCanUseLabel = UILabel().then{
        $0.text = "*영문, 숫자 포함 8자리 이상 "
        $0.textColor = .noticeRed
        $0.labelTypeSetting(type: .sub1)
        $0.isHidden = true
    }

    let pwCertificationTextField = UITextField().then{
        $0.placeholder = "비밀번호 재입력"
        $0.textFieldTypeSetting()
        $0.isSecureTextEntry = true
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let pwCertificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let pwIncorrectLabel = UILabel().then{
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textColor = .noticeRed
        $0.labelTypeSetting(type: .sub1)
        $0.isHidden = true
    }

    //name
    let nameTitle = UILabel().then{
        $0.text = "이름"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .subtitle)
    }

    let nameTextField = UITextField().then{
        $0.placeholder = "이름을 입력해주세요"
        $0.textFieldTypeSetting()
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let nameBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let nameCanUseLabel = UILabel().then{
        $0.text = "*8자 이하의 한글 또는 영어로만 가능합니다."
        $0.textColor = .todoaryGrey
        $0.labelTypeSetting(type: .sub1)
    }

    //nickname
    let nicknameTitle = UILabel().then{
        $0.text = "닉네임"
        $0.textColor = .headline
        $0.labelTypeSetting(type: .subtitle)
    }

    let nicknameTextField = UITextField().then{
        $0.placeholder = "Todoary에서 사용하실 닉네임을 알려주세요"
        $0.textFieldTypeSetting()
        $0.returnKeyType = .done
        $0.enablesReturnKeyAutomatically = true
    }

    let nicknameBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let nicknameCanUseLabel = UILabel().then{
        $0.text = "*10자 이하의 한글,영어,숫자로만 가능합니다."
        $0.textColor = .todoaryGrey
        $0.labelTypeSetting(type: .sub1)
    }

    let nextButton = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.buttonTypeSetting(type: .button1)
        $0.layer.cornerRadius = 52/2
    }

    override func hierarchy(){

        addSubview(idTitle)
        addSubview(idTextField)
        addSubview(idBorderLine)
        addSubview(idCanUseLabel)
        addSubview(idCertificationButton)

        addSubview(certificationTitle)
        addSubview(certificationTextField)
        addSubview(certificationBorderLine)
        addSubview(certificationOkButton)
        
        addSubview(pwTitle)
        addSubview(pwTextField)
        addSubview(pwBorderLine)
        addSubview(pwCanUseLabel)
        
        addSubview(pwCertificationTextField)
        addSubview(pwCertificationBorderLine)
        addSubview(pwIncorrectLabel)
        
        addSubview(nameTitle)
        addSubview(nameTextField)
        addSubview(nameBorderLine)
        addSubview(nameCanUseLabel)
        
        addSubview(nicknameTitle)
        addSubview(nicknameTextField)
        addSubview(nicknameBorderLine)
        addSubview(nicknameCanUseLabel)
        
        addSubview(nextButton)
    
    }
    
    override func layout(){

        //id
        idTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(59)
            make.leading.equalToSuperview().offset(38)
        }

        idTextField.snp.makeConstraints{ make in
            make.top.equalTo(idTitle.snp.bottom).offset(16)
            make.height.equalTo(20)
            make.trailing.equalToSuperview().offset(-50)
            make.leading.equalTo(idTitle)
        }
        
        idBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.equalTo(idTextField)
            make.trailing.equalToSuperview().offset(-38)
            make.bottom.equalTo(idTextField).offset(2)
        }
        
        idCanUseLabel.snp.makeConstraints{ make in
            make.height.equalTo(20)
            make.top.equalTo(idBorderLine.snp.bottom).offset(6)
            make.leading.equalTo(idTitle)
        }
        
        idCertificationButton.snp.makeConstraints{ make in
            make.width.equalTo(65)
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(55)
        }
        
        //certification
        certificationTitle.snp.makeConstraints{ make in
            make.top.equalTo(idCanUseLabel.snp.bottom).offset(8)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
        }

        certificationTextField.snp.makeConstraints{ make in
            make.top.equalTo(certificationTitle.snp.bottom).offset(16)
            make.height.equalTo(20)
            make.leading.equalTo(idTitle)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        certificationBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(idBorderLine)
            make.bottom.equalTo(certificationTextField).offset(2)
        }
        
        certificationOkButton.snp.makeConstraints{ make in
            make.width.equalTo(65)
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(idCanUseLabel.snp.bottom).offset(7)
        }
        
        //password
        pwTitle.snp.makeConstraints{ make in
            make.top.equalTo(certificationBorderLine).offset(48)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
        }
        
        pwTextField.snp.makeConstraints{ make in
            make.top.equalTo(pwTitle.snp.bottom).offset(17)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        pwBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(idBorderLine)
            make.bottom.equalTo(pwTextField.snp.bottom).offset(2)
        }
        
        pwCanUseLabel.snp.makeConstraints{ make in
            make.top.equalTo(pwBorderLine.snp.bottom).offset(7)
            make.leading.trailing.equalTo(idTextField)
            make.height.equalTo(20)
        }
        
        pwCertificationTextField.snp.makeConstraints{ make in
            make.top.equalTo(pwCanUseLabel.snp.bottom).offset(13)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        pwCertificationBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(idBorderLine)
            make.bottom.equalTo(pwCertificationTextField.snp.bottom).offset(3)
        }
        
        pwIncorrectLabel.snp.makeConstraints{ make in
            make.top.equalTo(pwCertificationBorderLine.snp.bottom).offset(7)
            make.leading.equalTo(idTextField.snp.leading)
            make.height.equalTo(20)
        }
        
        //name
        nameTitle.snp.makeConstraints{ make in
            make.top.equalTo(pwIncorrectLabel).offset(33)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
        }
        
        nameTextField.snp.makeConstraints{ make in
            make.top.equalTo(nameTitle.snp.bottom).offset(16)
            make.height.equalTo(20)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        nameBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(certificationBorderLine)
            make.height.equalTo(1)
            make.leading.equalTo(idTextField.snp.leading)
            make.bottom.equalTo(nameTextField.snp.bottom).offset(4)
        }
        
        nameCanUseLabel.snp.makeConstraints{ make in
            make.top.equalTo(nameBorderLine.snp.bottom).offset(7)
            make.leading.equalTo(idTextField.snp.leading)
            make.height.equalTo(20)
        }
        
        //nickname
        nicknameTitle.snp.makeConstraints{ make in
            make.top.equalTo(nameCanUseLabel.snp.bottom).offset(19)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
        }
        
        nicknameTextField.snp.makeConstraints{ make in
            make.top.equalTo(nicknameTitle.snp.bottom).offset(16)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        nicknameBorderLine.snp.makeConstraints{ make in
            make.leading.trailing.equalTo(idBorderLine)
            make.height.equalTo(1)
            make.bottom.equalTo(nicknameTextField.snp.bottom).offset(4)
        }
        
        nicknameCanUseLabel.snp.makeConstraints{ make in
            make.top.equalTo(nicknameBorderLine.snp.bottom).offset(7)
            make.leading.equalTo(idTextField.snp.leading)
            make.height.equalTo(20)
        }
        
        //button
        nextButton.snp.makeConstraints{ make in
            make.top.greaterThanOrEqualTo(nicknameCanUseLabel)
            make.bottom.equalToSuperview().offset(-47)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(52)
        }
    }
}
