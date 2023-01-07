//
//  PinNumberSettingViewController+Layout.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/14.
//

import UIKit

extension PinNumberSettingViewController {
    
    func setUpView(){
        
        self.view.addSubview(pinTitle)
        self.view.addSubview(pinSwitch)
        self.view.addSubview(pinBorderLine)
        
        self.view.addSubview(backView)
        self.backView.addSubview(pinSetting)
        self.backView.addSubview(nextBtn)
        self.view.addSubview(pinSettingBorderLine)



    
    }
    
    func setUpConstraint(){

        
        pinTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(138)
            make.leading.equalToSuperview().offset(31)
        }
        
        pinSwitch.snp.makeConstraints{ make in
            make.centerY.equalTo(pinTitle).offset(-2)
            make.trailing.equalToSuperview().offset(-31)
            make.width.equalTo(44)
            make.height.equalTo(27)
        }
        
        pinBorderLine.snp.makeConstraints{ make in
            make.top.equalTo(pinTitle.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(1)
        }
        
        backView.snp.makeConstraints{ make in
            make.top.equalTo(pinBorderLine.snp.bottom)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(50)
        }
        
        pinSetting.snp.makeConstraints{ make in
            make.centerY.equalTo(backView)
            make.leading.equalTo(backView.snp.leading)

        }
        
        nextBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(pinSetting)
            make.trailing.equalTo(backView.snp.trailing)
        }
        
        pinSettingBorderLine.snp.makeConstraints{ make in
            make.top.equalTo(backView.snp.bottom)
            make.leading.equalTo(backView.snp.leading)
            make.trailing.equalTo(backView.snp.trailing)
            make.height.equalTo(1)
        }

    }
}

