//
//  PinNumberSettingView.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/14.
//

import UIKit

class PinNumberSettingView: BaseView{
    
    //MARK: - UI
    
    let pinTitle = UILabel().then{
        $0.text = "암호 설정"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let pinSwitch = UISwitch()
    
    let pinBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let backView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let pinSetting = UILabel().then{
        $0.text = "암호 변경"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let nextBtn = UIButton().then{
        $0.setImage(UIImage(named: "next_btn"), for: .normal)
    }
    
    let pinSettingBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    //MARK: - BaseProtocol
    
    override func hierarchy(){
        
        self.addSubview(pinTitle)
        self.addSubview(pinSwitch)
        self.addSubview(pinBorderLine)
        
        self.addSubview(backView)
        self.backView.addSubview(pinSetting)
        self.backView.addSubview(nextBtn)
        self.addSubview(pinSettingBorderLine)
    }
    
    override func layout(){

        pinTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(26)
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

