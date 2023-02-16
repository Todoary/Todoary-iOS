//
//  CategoryTodoTableViewCell+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/01.
//

import Foundation

extension CategoryTodoTableViewCell{
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        self.addSubview(deleteButton)
        
        backView.addSubview(categoryLabel)
        backView.addSubview(checkBox)
        backView.addSubview(todoTitle)
        backView.addSubview(timeStack)
        
        timeStack.addArrangedSubview(dateLabel)
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(todoTitle.snp.height).offset(69+19)
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        categoryLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(19)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(21)
            make.width.equalTo(categoryLabel.titleLabel!).offset(22)
        }
        
        checkBox.snp.makeConstraints{ make in
            make.width.height.equalTo(22)
//            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.top.equalToSuperview().offset(44.36)
            make.leading.equalToSuperview().offset(19)
        }
        
        todoTitle.snp.makeConstraints{ make in
//            make.width.equalTo(177)
            make.trailing.equalToSuperview().offset(-101)
            make.centerY.equalTo(checkBox)
//            make.top.equalTo(checkBox).offset(-2)
//            make.bottom.equalToSuperview().offset(-19)
            make.leading.equalTo(checkBox.snp.trailing).offset(9)
        }
        
        
        timeStack.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-18)
//            make.leading.equalTo(todoTitle.snp.trailing).offset(12)
            make.bottom.equalToSuperview().offset(-23)
        }
        
        dateLabel.snp.makeConstraints{ make in
            make.width.equalTo(71)
            make.height.equalTo(14.14)
        }
        
        deleteButton.snp.makeConstraints{ make in
            make.width.height.equalTo(22)
            make.leading.equalToSuperview().offset(18.5)
            make.centerY.equalTo(backView)
        }
        
    }
    
    func setUpTimeStack(){
        
        if(todoData.isAlarmEnabled){
            
            timeView.addArrangedSubview(alarmImage)
            timeView.addArrangedSubview(timeLabel)
            
            timeStack.addArrangedSubview(timeView)
            
            alarmImage.snp.makeConstraints{ make in
                make.width.equalTo(14)
//                make.height.equalTo(13)
//                make.height.equalToSuperview()
            }
        }
    }
}
