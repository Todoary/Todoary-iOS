//
//  AgreementView.swift
//  Todoary
//
//  Created by 예리 on 2022/07/02.
//

import UIKit
import SnapKit


class AgreementView: BaseView {

    private let agreeTitle = UILabel().then{
        $0.text = "Todoary 서비스 이용약관에 동의해주세요."
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.setTypoStyleWithSingleLine(typoStyle: .bold16_19)
    }
    private let agreementTitleBorderLine = UIView().then{
        $0.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
    }

    let privacyField = AgreementField().then{
        $0.titleLabel.text = "개인 정보 취급방침 동의 (필수)"
    }
    let userServiceField = AgreementField().then{
        $0.titleLabel.text = "서비스 이용약관 동의 (필수)"
    }
    let advertiseField = AgreementField().then{
        $0.titleLabel.text = "광고성 정보 수신 동의 (선택)"
    }
    let allCheckBtn = UIButton().then{
        $0.setImage(Image.blackCheckBoxFill, for: .selected)
        $0.setImage(Image.blackCheckBoxBlank, for: .normal)
    }
    let allCheckText = UILabel().then{
        $0.text = "전체동의"
        $0.setTypoStyleWithSingleLine(typoStyle: .bold14)
    }

    let confirmBtn = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .buttonColor
        let font: TypoStyle = Const.Device.isSmallDevice ? .semibold14 : .semibold18
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: font)
        let height: CGFloat = Const.Device.isSmallDevice ? 40 : 52
        $0.layer.cornerRadius = height / 2
    }

    override func hierarchy(){
        
        self.addSubview(agreeTitle)
        self.addSubview(agreementTitleBorderLine)
        
        self.addSubview(privacyField)
        self.addSubview(userServiceField)
        self.addSubview(advertiseField)
        
        self.addSubview(allCheckBtn)
        self.addSubview(allCheckText)

        self.addSubview(confirmBtn)
        
    }
    
    override func layout(){
        agreeTitle.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(56)
            $0.centerX.equalToSuperview()
        }
        
        agreementTitleBorderLine.snp.makeConstraints{
            $0.top.equalTo(agreeTitle.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(31)
            $0.height.equalTo(1)
        }
        
        privacyField.snp.makeConstraints{
            $0.top.equalTo(agreementTitleBorderLine.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        userServiceField.snp.makeConstraints{
            $0.top.equalTo(privacyField.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        advertiseField.snp.makeConstraints{
            $0.top.equalTo(userServiceField.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        allCheckBtn.snp.makeConstraints{
            $0.width.height.equalTo(20)
            $0.leading.equalToSuperview().offset(31)
            $0.top.equalTo(advertiseField.snp.bottom).offset(15)
        }
        
        allCheckText.snp.makeConstraints{
            $0.centerY.equalTo(allCheckBtn)
            $0.leading.equalTo(allCheckBtn.snp.trailing).offset(8)
            
        }
        
        confirmBtn.snp.makeConstraints{
            let bottomOffset = Const.Device.isSmallDevice ? 17 : 47
            let height: CGFloat = Const.Device.isSmallDevice ? 40 : 52
            let leadingTrailingOffset = Const.Device.isSmallDevice ? 31 : 26
            $0.bottom.equalToSuperview().inset(bottomOffset)
            $0.height.equalTo(height)
            $0.leading.trailing.equalToSuperview().inset(leadingTrailingOffset)
        }
    }
}

extension AgreementView{
    
    class AgreementField: BaseView{
        
        var isSelected = false{
            didSet{
                checkBox.isSelected = isSelected
            }
        }
        
        let checkBox = UIButton().then{
            $0.setImage(Image.blackCheckBoxFill, for: .selected)
            $0.setImage(Image.blackCheckBoxBlank, for: .normal)
        }
        
        let titleLabel = UILabel().then{
            $0.isUserInteractionEnabled = true
            $0.setTypoStyleWithSingleLine(typoStyle: .medium14_16)
            $0.setUnderline()
        }
        
        let borderLine = UIView().then{
            $0.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        }
        
        override func hierarchy() {
            self.addSubview(checkBox)
            self.addSubview(titleLabel)
            self.addSubview(borderLine)
        }
        
        override func layout() {
            checkBox.snp.makeConstraints{
                $0.width.height.equalTo(20)
                $0.top.equalToSuperview().offset(15)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().offset(31)
            }
            
            titleLabel.snp.makeConstraints{
                $0.leading.equalTo(checkBox.snp.trailing).offset(8)
                $0.centerY.equalToSuperview()
            }
            
            borderLine.snp.makeConstraints{
                $0.height.equalTo(1)
                $0.leading.trailing.equalToSuperview().inset(31)
                $0.bottom.equalToSuperview().offset(-1)
            }
        }
    }
}
