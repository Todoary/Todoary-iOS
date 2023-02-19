//
//  HiddenTransparentButtonView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/19.
//

import UIKit

class HiddenRightButtonView: BaseView {

    lazy var deleteButton = UIButton().then{
        $0.setImage(Image.trash, for: .normal)
    }
    let transparentView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    override func hierarchy() {
        self.addSubview(transparentView)
        transparentView.addSubview(deleteButton)
    }
    
    override func layout() {

        self.snp.makeConstraints{
            $0.height.equalTo(60)
            $0.width.equalTo(58) //105
        }

        transparentView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints{
            $0.width.height.equalTo(30)
            $0.trailing.equalToSuperview().offset(-14)
            $0.centerY.equalToSuperview()
        }
    }
}

class HiddenLeftButtonView: BaseView{
    
    lazy var pinButton = UIButton().then{
        $0.setImage(Image.pushPinBig, for: .normal)
        $0.setImage(Image.pushPinBigFill, for: .selected)
    }
    
    lazy var alarmBtn = UIButton().then{
        $0.setImage(Image.alarm, for: .normal)
        $0.setImage(Image.alarmActivate, for: .selected)
    }
    
    let borderLine = UIView().then{
        $0.backgroundColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
    }
    
    let transparentView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    override func hierarchy() {
        self.addSubview(transparentView)
        transparentView.addSubview(pinButton)
        transparentView.addSubview(alarmBtn)
        transparentView.addSubview(borderLine)
    }
    
    override func layout() {
        self.snp.makeConstraints{
            $0.height.equalTo(60)
            $0.width.equalTo(105) // 58
        }

        transparentView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        pinButton.snp.makeConstraints{
            $0.width.height.equalTo(28)
            $0.leading.equalToSuperview().offset(18)
            $0.centerY.equalToSuperview()
        }
        
        borderLine.snp.makeConstraints{
            $0.width.height.equalTo(1)
            $0.top.equalToSuperview().offset(17)
            $0.bottom.equalToSuperview().offset(-15)
            $0.leading.equalTo(pinButton.snp.trailing).offset(10)
        }
        
        alarmBtn.snp.makeConstraints{
            $0.width.height.equalTo(28)
            $0.leading.equalTo(borderLine.snp.trailing).offset(11)
            $0.centerY.equalToSuperview()
        }
    }
}
