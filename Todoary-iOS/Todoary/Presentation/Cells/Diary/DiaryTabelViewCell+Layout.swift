//
//  DiaryTabelViewCell+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/30.
//

import Foundation
extension DiaryTabelViewCell{
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        self.backView.addSubview(checkBox)
        self.backView.addSubview(titleLabel)
        self.backView.addSubview(timeLabel)
        self.backView.addSubview(categoryButton)
   
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(75)
            make.top.equalToSuperview().offset(7.5)
            make.bottom.equalToSuperview().offset(-7.5)
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        checkBox.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalTo(checkBox.snp.trailing).offset(13)
            make.centerY.equalTo(checkBox)
        }
        
        timeLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalToSuperview().offset(23.4)
            make.bottom.equalToSuperview().offset(-22.46)
            //            make.lastBaseline.equalTo(alarmImage)
        }
        
        categoryButton.snp.makeConstraints{ make in
//            make.width.equalTo(categoryButton.titleLabel!.snp.width).offset(24)
            make.height.equalTo(21)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(timeLabel.snp.leading).offset(-7)
        }
    }
    
    func setUpViewByCase(){
        
        if(cellData.isAlarmEnabled){
            
            self.backView.addSubview(alarmImage)
            alarmImage.snp.makeConstraints{ make in
                make.width.equalTo(14)
                make.height.equalTo(13.2)
                make.trailing.equalTo(timeLabel.snp.leading).offset(-5)
                make.centerY.equalToSuperview()
                make.top.equalToSuperview().offset(23.4)
                make.bottom.equalToSuperview().offset(-23.4)
                make.lastBaseline.equalTo(timeLabel)
            }
        }
    }
}
