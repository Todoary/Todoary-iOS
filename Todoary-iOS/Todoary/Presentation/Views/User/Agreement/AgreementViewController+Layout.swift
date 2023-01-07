//
//  AgreementViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/02.
//

import UIKit
import SnapKit


extension AgreementViewController {
    
    func setUpView(){
        
        self.view.addSubview(navigationView)
        
        self.view.addSubview(agreeTitle)
        
        self.view.addSubview(privacyBorderLine)
        self.view.addSubview(privacyCheckBtn)
        self.view.addSubview(privacyTitle)
        
        self.view.addSubview(useServiceBorderLine)
        self.view.addSubview(useServiceCheckBtn)
        self.view.addSubview(useServiceTitle)

        self.view.addSubview(adBorderLine)
        self.view.addSubview(adCheckBtn)
        self.view.addSubview(adTitle)
   

        self.view.addSubview(locationBorderLine)
//        self.view.addSubview(locationCheckBtn)
//        self.view.addSubview(locationTitle)
        //
        
        self.view.addSubview(agreeAllBorderLine)
        self.view.addSubview(allCheckBtn)
        self.view.addSubview(allCheckText)

        self.view.addSubview(confirmBtn)
        
    }
    
    
    func setUpConstraint(){
        
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        //Title
        agreeTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(145)
            make.leading.equalToSuperview().offset(56)
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
        
//        locationCheckBtn.snp.makeConstraints{make in
//            make.width.equalTo(20)
//            make.height.equalTo(20)
//            make.left.equalTo(privacyBorderLine)
//            make.top.equalTo(locationBorderLine.snp.bottom).offset(13)
//        }
//
//        locationTitle.snp.makeConstraints{make in
//            make.height.equalTo(18)
//            make .width.equalTo(146)
//            make.centerY.equalTo(locationCheckBtn)
//            make.leading.equalTo(locationCheckBtn.snp.trailing).offset(8)
//        }
        
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

