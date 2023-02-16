//
//  AgreementView.swift
//  Todoary
//
//  Created by 예리 on 2022/07/02.
//

import UIKit
import SnapKit


class AgreementView: BaseView {
    
    //MARK: - 텍스트

    let agreeTitle = UILabel().then{
        $0.text = "Todoary 서비스 이용약관에 동의해 주세요."
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }
    
    let allCheckText = UILabel().then{
        $0.text = "전체동의"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }
    
    //MARK: - 약관 제목버튼(약관 내용페이지로 연결)
    
    let privacyTitle = UIButton().then{
        $0.setTitle("개인 정보 취급방침 동의 (필수)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.setUnderline()
    }
    
    let useServiceTitle = UIButton().then{
        $0.setTitle("서비스 이용약관 동의 (필수)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.setUnderline()
    }
    
    let adTitle = UIButton().then{
        $0.setTitle("광고성 정보 수신 동의 (선택)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.titleLabel?.textAlignment = .left
        $0.setUnderline()
    }
    
    //MARK: - 약관 체크버튼 (필수 동의를 해야만 확인버튼을 누를수 있음)
    
    let allCheckBtn = UIButton().then{
        $0.setImage(Image.blackCheckBoxFill, for: .selected)
        $0.setImage(Image.blackCheckBoxBlank, for: .normal)
    }
    
    let privacyCheckBtn = UIButton().then{
        $0.setImage(Image.blackCheckBoxFill, for: .selected)
        $0.setImage(Image.blackCheckBoxBlank, for: .normal)
    }
    
    let useServiceCheckBtn = UIButton().then{
        $0.setImage(Image.blackCheckBoxFill, for: .selected)
        $0.setImage(Image.blackCheckBoxBlank, for: .normal)
    }
    
    let adCheckBtn = UIButton().then{
        $0.setImage(Image.blackCheckBoxFill, for: .selected)
        $0.setImage(Image.blackCheckBoxBlank, for: .normal)
    }

    //MARK: - BorderLine
    
    let privacyBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let useServiceBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let adBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let locationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let agreeAllBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    //MARK: -  확인 버튼(필수 동의를 마치면 활성화)
    
    let confirmBtn = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .buttonColor
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
    }

    override func hierarchy(){
        
        self.addSubview(agreeTitle)
        
        self.addSubview(privacyBorderLine)
        self.addSubview(privacyCheckBtn)
        self.addSubview(privacyTitle)
        
        self.addSubview(useServiceBorderLine)
        self.addSubview(useServiceCheckBtn)
        self.addSubview(useServiceTitle)

        self.addSubview(adBorderLine)
        self.addSubview(adCheckBtn)
        self.addSubview(adTitle)
   

        self.addSubview(locationBorderLine)
        
        self.addSubview(agreeAllBorderLine)
        self.addSubview(allCheckBtn)
        self.addSubview(allCheckText)

        self.addSubview(confirmBtn)
        
    }
    
    override func layout(){
        //Title
        agreeTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
        }
        
        //약관제목&체크
        privacyBorderLine.snp.makeConstraints{make in
            make.height.equalTo(1)
            make .width.equalTo(328)
            make.centerX.equalTo(agreeTitle)
            make.top.equalTo(agreeTitle.snp.bottom).offset(28)
        }
        
        privacyCheckBtn.snp.makeConstraints{make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.left.equalTo(privacyBorderLine)
            make.top.equalTo(privacyBorderLine.snp.bottom).offset(13)
        }
        
        privacyTitle.snp.makeConstraints{make in
            make.height.equalTo(18)
            make .width.equalTo(174)
            make.centerY.equalTo(privacyCheckBtn)
            make.leading.equalTo(privacyCheckBtn.snp.trailing).offset(8)
        }
        
        useServiceBorderLine.snp.makeConstraints{make in
            make.height.equalTo(1)
            make .width.equalTo(328)
            make.centerX.equalTo(agreeTitle)
            make.top.equalTo(privacyTitle.snp.bottom).offset(15)
        }
        
        useServiceCheckBtn.snp.makeConstraints{make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.left.equalTo(privacyBorderLine)
            make.top.equalTo(useServiceBorderLine.snp.bottom).offset(13)
        }
        
        useServiceTitle.snp.makeConstraints{make in
            make.height.equalTo(18)
            make .width.equalTo(158)
            make.centerY.equalTo(useServiceCheckBtn)
            make.leading.equalTo(useServiceCheckBtn.snp.trailing).offset(8)
        }
        
        adBorderLine.snp.makeConstraints{make in
            make.height.equalTo(1)
            make .width.equalTo(328)
            make.centerX.equalTo(agreeTitle)
            make.top.equalTo(useServiceTitle.snp.bottom).offset(15)
        }
        
        adCheckBtn.snp.makeConstraints{make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.left.equalTo(privacyBorderLine)
            make.top.equalTo(adBorderLine.snp.bottom).offset(13)
        }
        
        adTitle.snp.makeConstraints{make in
            make.height.equalTo(18)
            make .width.equalTo(162)
            make.centerY.equalTo(adCheckBtn)
            make.leading.equalTo(adCheckBtn.snp.trailing).offset(8)
        }
        
        locationBorderLine.snp.makeConstraints{make in
            make.height.equalTo(1)
            make .width.equalTo(328)
            make.centerX.equalTo(agreeTitle)
            make.top.equalTo(adTitle.snp.bottom).offset(15)
        }
     
        agreeAllBorderLine.snp.makeConstraints{make in
            make.height.equalTo(1)
            make .width.equalTo(328)
            make.centerX.equalTo(agreeTitle)
            make.top.equalTo(adTitle.snp.bottom).offset(15)
        }
        
        allCheckBtn.snp.makeConstraints{ make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.left.equalTo(agreeAllBorderLine)
            make.top.equalTo(agreeAllBorderLine.snp.bottom).offset(15)
        }
        
        allCheckText.snp.makeConstraints{ make in
            make.width.equalTo(58)
            make.height.equalTo(19)
            make.centerY.equalTo(allCheckBtn)
            make.leading.equalTo(allCheckBtn.snp.trailing).offset(8)
            
        }
        
        //button
        confirmBtn.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-47)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(52)
        }
    }
}

