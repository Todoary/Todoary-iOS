//
//  HiddenTransparentButtonView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/19.
//

import UIKit

class HiddenRightButtonView: UIView {

    lazy var deleteButton = UIButton().then{
        $0.setImage(Image.trash, for: .normal)
    }
    let transparentView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpView(){
        self.addSubview(transparentView)
        transparentView.addSubview(deleteButton)
    }
    
    func setUpConstraint(){

        self.snp.makeConstraints{ make in
            make.height.equalTo(60)
            make.width.equalTo(58) //105
        }

        transparentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints{ make in
            make.width.height.equalTo(30)
            make.trailing.equalToSuperview().offset(-14)
            make.centerY.equalToSuperview()
        }
    }
}


class HiddenLeftButtonView: UIView{
    
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
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(transparentView)
    
        transparentView.addSubview(pinButton)
        transparentView.addSubview(alarmBtn)
        transparentView.addSubview(borderLine)
        
        self.snp.makeConstraints{ make in
            make.height.equalTo(60)
            make.width.equalTo(105) // 58
        }

        transparentView.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        pinButton.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.leading.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }
        
        borderLine.snp.makeConstraints{ make in
            make.width.height.equalTo(1)
            make.top.equalToSuperview().offset(17)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalTo(pinButton.snp.trailing).offset(10)
        }
        
        alarmBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
            make.leading.equalTo(borderLine.snp.trailing).offset(11)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
