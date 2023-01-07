//
//  TodoSettingViewController+Layout.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/23.
//

import UIKit

extension TodoSettingViewController {
    
    func setUpView(){
        
        self.view.addSubview(completeBtn)
        self.view.addSubview(todo)
        self.view.addSubview(todoBorderLine)
        
        self.view.addSubview(dateTitle)
        self.view.addSubview(date)
        self.view.addSubview(dateBorderLine)

        self.view.addSubview(alarm)
        self.view.addSubview(time)
        self.view.addSubview(alarmSwitch)
        self.view.addSubview(alarmBorderLine)
        
        self.view.addSubview(category)
        self.view.addSubview(plusBtn)
        self.view.addSubview(collectionView)
        self.view.addSubview(categoryBorderLine)

    }
    
    func setUpConstraint(){
        
        completeBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.trailing.equalToSuperview().offset(-21)
            make.width.equalTo(35)
            make.height.equalTo(22)
        }
        
        todo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(111)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
        }
        
        todoBorderLine.snp.makeConstraints{ make in
            make.top.equalTo(todo.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(1)
        }
        
        dateTitle.snp.makeConstraints{ make in
            make.top.equalTo(todoBorderLine.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(31)
        }
        
        date.snp.makeConstraints{ make in
            make.centerY.equalTo(dateTitle)
            make.trailing.equalToSuperview().offset(-31)
            make.width.equalTo(107)
            make.height.equalTo(17)

        }
        
        dateBorderLine.snp.makeConstraints{ make in
            make.top.equalTo(dateTitle.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(1)
        }
        
        alarm.snp.makeConstraints{ make in
            make.top.equalTo(dateBorderLine.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(31)
        }
        
        alarmSwitch.snp.makeConstraints{ make in
            make.centerY.equalTo(alarm).offset(-2)
            make.trailing.equalToSuperview().offset(-31)
            make.width.equalTo(44)
            make.height.equalTo(27)
        }
        
        time.snp.makeConstraints{ make in
            make.centerY.equalTo(alarm)
            make.trailing.equalTo(alarmSwitch.snp.leading).offset(-15)
            make.width.equalTo(64)
            make.height.equalTo(17)
        }
        
        alarmBorderLine.snp.makeConstraints{ make in
            make.top.equalTo(alarm.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(1)
        }
        
        category.snp.makeConstraints{ make in
            make.top.equalTo(alarmBorderLine.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(31)
        }
        
        plusBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(category)
            make.trailing.equalToSuperview().offset(-21)
            make.width.equalTo(35)
            make.height.equalTo(38.26)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(category.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(275)
        }
        
        categoryBorderLine.snp.makeConstraints{ make in
            make.top.equalTo(collectionView.snp.bottom).offset(19)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(1)
        }
    }
}

