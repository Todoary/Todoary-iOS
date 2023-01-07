//
//  PwFindView.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/02.
//
import UIKit

class PwFindView: BaseView {
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
        $0.addLetterSpacing(spacing: 0.32)
    }
    
    let idTextField = UITextField().then{
        $0.placeholder = "이메일을 입력해주세요"
        $0.setPlaceholderColor()
        $0.font = UIFont.nbFont(type: .body2)
        $0.textFieldTypeSetting(type: .body1)
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }
    
    let idNoticeLabel = UILabel().then{
        $0.text = "*가입시 등록했던 이메일을 입력해주세요 "
        $0.textColor = .todoaryGrey
        $0.addLetterSpacing(spacing: 0.36)
        $0.font = UIFont.nbFont(type: .sub1)
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let idCertificationButton = UIButton().then{
        $0.setTitle("인증하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.buttonTypeSetting(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
    }
    
    //인증코드
    let certificationTitle = UILabel().then{
        $0.text = "인증코드 입력"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
        $0.addLetterSpacing(spacing: 0.32)
        
    }

    let certificationTextField = UITextField().then{
        $0.font = UIFont.nbFont(type: .body2)
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let certificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let certificationOkButton = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .subButton)
        $0.buttonTypeSetting(type: .subButton)
        $0.backgroundColor = .buttonColor
        $0.layer.cornerRadius = 22/2
    }

    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호 재설정"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
        $0.addLetterSpacing(spacing: 0.32)
    }

    let pwTextField = UITextField().then{
        $0.placeholder = "영문, 숫자 포함 8자리 이상"
        $0.isSecureTextEntry = true
        $0.setPlaceholderColor()
        $0.font = UIFont.nbFont(type: .body2)
        $0.textFieldTypeSetting(type: .body1)
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let pwBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let pwNoticeLabel = UILabel().then{
        $0.isHidden = true
        $0.text = "*영문, 숫자 포함 8자리 이상 입력해주세요 "
        $0.labelTypeSetting(type: .sub1)
        $0.textColor = .noticeRed
        $0.font = UIFont.nbFont(type: .sub1)
    }

    let pwCertificationTextField = UITextField().then{
        $0.placeholder = "비밀번호 재입력"
        $0.setPlaceholderColor()
        $0.isSecureTextEntry = true
        $0.font = UIFont.nbFont(type: .body2)
        $0.textFieldTypeSetting(type: .body1)
        $0.returnKeyType = .done
        $0.enablesReturnKeyAutomatically = true
    }

    let pwCertificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let pwCertificationNoticeLabel = UILabel().then{
        $0.isHidden = true
        $0.text = "*비밀번호가 일치하지 않습니다 "
        $0.labelTypeSetting(type: .sub1)
        $0.textColor = .noticeRed
        $0.font = UIFont.nbFont(type: .sub1)
    }


    let confirmButton = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
    }

    
    override func hierarchy(){

        self.addSubview(idTitle)
        self.addSubview(idTextField)
        self.addSubview(idBorderLine)
        
        self.addSubview(idNoticeLabel)

        self.addSubview(idCertificationButton)

        self.addSubview(certificationTitle)
        self.addSubview(certificationTextField)
        self.addSubview(certificationBorderLine)
        self.addSubview(certificationOkButton)
        
        self.addSubview(pwTitle)
        self.addSubview(pwTextField)
        self.addSubview(pwBorderLine)
        self.addSubview(pwNoticeLabel)
        
        self.addSubview(pwCertificationTextField)
        self.addSubview(pwCertificationBorderLine)
        self.addSubview(pwCertificationNoticeLabel)
        
        self.addSubview(confirmButton)
    
    }
    
    override func layout(){
        
        //id
        idTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(72)
            make.leading.equalToSuperview().offset(38)
        }

        idTextField.snp.makeConstraints{ make in
            make.top.equalTo(idTitle.snp.bottom).offset(16)
            make.width.equalTo(idBorderLine)
            make.height.equalTo(20)
            make.leading.equalTo(idTitle)
        }
        
        idBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(314)
            make.height.equalTo(1)
            make.leading.equalTo(idTextField.snp.leading)
            make.bottom.equalTo(idTextField.snp.bottom).offset(3)
        }
        
        idNoticeLabel.snp.makeConstraints{ make in
            make.top.equalTo(idBorderLine).offset(9)
            make.leading.equalToSuperview().offset(38)
        }
        
        idCertificationButton.snp.makeConstraints{ make in
            make.width.equalTo(65)
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-40)
            make.centerY.equalTo(idTitle).offset(-2)
        }
        
        //certification
        certificationTitle.snp.makeConstraints{ make in
            make.top.equalTo(idBorderLine.snp.bottom).offset(46)
            make.leading.equalTo(idTitle)
        }

        certificationTextField.snp.makeConstraints{ make in
            make.top.equalTo(certificationTitle.snp.bottom).offset(16)
            make.height.equalTo(20)
            make.leading.equalTo(idTitle)
            make.width.equalTo(idBorderLine)
        }
        
        certificationBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.equalTo(idTextField.snp.leading)
            make.trailing.equalToSuperview().offset(-38)
            make.bottom.equalTo(certificationTextField.snp.bottom).offset(3)
        }
        
        certificationOkButton.snp.makeConstraints{ make in
            make.width.equalTo(65)
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(idBorderLine.snp.bottom).offset(45)
        }
        
        //password
        pwTitle.snp.makeConstraints{ make in
            make.top.equalTo(certificationBorderLine).offset(55)
            make.leading.equalTo(idTitle)
        }
        
        pwTextField.snp.makeConstraints{ make in
            make.top.equalTo(pwTitle.snp.bottom).offset(17)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.width.equalTo(idBorderLine)
        }
        
        pwBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(certificationBorderLine)
            make.height.equalTo(1)
            make.leading.equalTo(idTextField.snp.leading)
            make.bottom.equalTo(pwTextField.snp.bottom).offset(3)
        }
        
        pwNoticeLabel.snp.makeConstraints{ make in
            make.top.equalTo(pwBorderLine).offset(7)
            make.leading.equalToSuperview().offset(38)
        }
        
        pwCertificationTextField.snp.makeConstraints{ make in
            make.top.equalTo(pwBorderLine.snp.bottom).offset(41)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.width.equalTo(idBorderLine)
        }
        
        pwCertificationBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(certificationBorderLine)
            make.height.equalTo(1)
            make.leading.equalTo(idTextField.snp.leading)
            make.bottom.equalTo(pwCertificationTextField.snp.bottom).offset(3)
        }
        
        pwCertificationNoticeLabel.snp.makeConstraints{ make in
            make.top.equalTo(pwCertificationBorderLine).offset(7)
            make.leading.equalToSuperview().offset(38)
        }
     
        
        //button
        confirmButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-47)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(52)
        }
    }
}
