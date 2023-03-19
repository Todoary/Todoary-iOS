//
//  SignUpView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/27.
//

import UIKit

class SignUpView: BaseView {
    
    private let isSmallDevice = Const.Device.isSmallDevice
    
    //id
    let idTitle = UILabel().then{
        $0.text = "아이디"
    }
    
    let idTextField = UITextField().then{
        $0.placeholder = "이메일을 입력해주세요"
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }
    
    let idBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let idCertificationButton = UIButton().then{
        $0.setTitle("인증하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        let typo: TypoStyle = Const.Device.isSmallDevice ? .medium8 : .medium10
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: typo)
        $0.backgroundColor = .buttonColor
        let smallButtonHeight: CGFloat = Const.Device.isSmallDevice ? 16 : 22
        $0.layer.cornerRadius = smallButtonHeight / 2
    }
    
    let idCanUseLabel = UILabel().then{
        $0.isHidden = true
    }
    
    //인증코드
    let certificationTitle = UILabel().then{
        $0.text = "인증코드 입력"
    }

    let certificationTextField = UITextField().then{
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let certificationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let certificationOkButton = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        let typo: TypoStyle = Const.Device.isSmallDevice ? .medium8 : .medium10
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: typo)
        $0.backgroundColor = .buttonColor
        let smallButtonHeight: CGFloat = Const.Device.isSmallDevice ? 16 : 22
        $0.layer.cornerRadius = smallButtonHeight / 2
    }

    //pw
    let pwTitle = UILabel().then{
        $0.text = "비밀번호"
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
        $0.isHidden = true
    }

    let pwCertificationTextField = UITextField().then{
        $0.placeholder = "비밀번호 재입력"
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
        $0.isHidden = true
    }

    //name
    let nameTitle = UILabel().then{
        $0.text = "이름"
    }

    let nameTextField = UITextField().then{
        $0.placeholder = "이름을 입력해주세요"
        $0.returnKeyType = .next
        $0.enablesReturnKeyAutomatically = true
    }

    let nameBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let nameCanUseLabel = UILabel().then{
        $0.text = "*8자 이하의 한글 또는 영어로만 가능합니다."
        $0.textColor = .todoaryGrey
    }

    //nickname
    let nicknameTitle = UILabel().then{
        $0.text = "닉네임"
    }

    let nicknameTextField = UITextField().then{
        $0.placeholder = "Todoary에서 사용하실 닉네임을 알려주세요"
        $0.returnKeyType = .done
        $0.enablesReturnKeyAutomatically = true
    }

    let nicknameBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let nicknameCanUseLabel = UILabel().then{
        $0.text = "*10자 이하의 한글,영어,숫자로만 가능합니다."
        $0.textColor = .todoaryGrey
    }

    let nextButton = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        let font: TypoStyle = Const.Device.isSmallDevice ? .semibold14 : .semibold18
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: font)
        let height: CGFloat = Const.Device.isSmallDevice ? 40 : 52
        $0.layer.cornerRadius = height / 2
    }
    
    override func style() {
        attributeSetting()
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
        
        let textFieldTopOffset = isSmallDevice ? 11.41 : 16
        let textFieldHeight = isSmallDevice ? 15 : 20
        let smallButtonWidth = isSmallDevice ? 46.35 : 65
        let smallButtonHeight = isSmallDevice ? 16 : 22

        //id
        idTitle.snp.makeConstraints{ make in
            let topOffset = isSmallDevice ? 25 : 59
            make.top.equalToSuperview().offset(topOffset)
            make.leading.equalToSuperview().offset(38)
        }

        idTextField.snp.makeConstraints{ make in
            make.top.equalTo(idTitle.snp.bottom).offset(textFieldTopOffset)
            make.height.equalTo(textFieldHeight)
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
            let topOffset = isSmallDevice ? 23 : 55
            make.top.equalToSuperview().offset(topOffset)
            make.width.equalTo(smallButtonWidth)
            make.height.equalTo(smallButtonHeight)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        //certification
        certificationTitle.snp.makeConstraints{ make in
            make.top.equalTo(idCanUseLabel.snp.bottom).offset(8)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
        }

        certificationTextField.snp.makeConstraints{ make in
            make.top.equalTo(certificationTitle.snp.bottom).offset(textFieldTopOffset)
            make.height.equalTo(textFieldHeight)
            make.leading.equalTo(idTitle)
            make.leading.trailing.equalTo(idBorderLine)
        }
        
        certificationBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(idBorderLine)
            make.bottom.equalTo(certificationTextField).offset(2)
        }
        
        certificationOkButton.snp.makeConstraints{ make in
            make.width.equalTo(smallButtonWidth)
            make.height.equalTo(smallButtonHeight)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(idCanUseLabel.snp.bottom).offset(7)
        }
        
        //password
        pwTitle.snp.makeConstraints{ make in
            let topOffset = isSmallDevice ? 34.6 : 48
            make.top.equalTo(certificationBorderLine).offset(topOffset)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
        }
        
        pwTextField.snp.makeConstraints{ make in
            make.top.equalTo(pwTitle.snp.bottom).offset(textFieldTopOffset)
            make.leading.equalTo(idTitle)
            make.height.equalTo(textFieldHeight)
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
            make.height.equalTo(textFieldHeight)
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
            make.top.equalTo(nameTitle.snp.bottom).offset(textFieldTopOffset)
            make.height.equalTo(textFieldHeight)
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
            make.top.equalTo(nicknameTitle.snp.bottom).offset(textFieldTopOffset)
            make.leading.equalTo(idTitle)
            make.height.equalTo(textFieldHeight)
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
            let bottomOffset = isSmallDevice ? 17 : 47
            let height = isSmallDevice ? 40 : 52
            let leadingTrailingOffset = Const.Device.isSmallDevice ? 31 : 26
            make.top.greaterThanOrEqualTo(nicknameCanUseLabel)
            make.bottom.equalToSuperview().inset(bottomOffset)
            make.leading.trailing.equalToSuperview().inset(leadingTrailingOffset)
            make.height.equalTo(height)
        }
    }
    
    private func attributeSetting(){
        
        let titleFont: TypoStyle  = isSmallDevice ? .bold13 : .bold16_19
        [idTitle, certificationTitle, pwTitle, nameTitle, nicknameTitle].forEach{
            $0.textColor = .headline
            $0.setTypoStyleWithSingleLine(typoStyle: titleFont)
        }
        
        let textFieldFont: TypoStyle = isSmallDevice ? .semibold10 : .semibold14
        [idTextField, certificationTextField, pwTextField,pwCertificationTextField, nameTextField, nicknameTextField].forEach{
            $0.textFieldTypoSetting(type: textFieldFont)
        }
        
        let explainLabelFont: TypoStyle = isSmallDevice ? .medium8 : .medium12_3
        [idCanUseLabel, pwCanUseLabel, pwIncorrectLabel, nameCanUseLabel, nicknameCanUseLabel].forEach{
            $0.setTypoStyleWithSingleLine(typoStyle: explainLabelFont)
        }
    }
}
