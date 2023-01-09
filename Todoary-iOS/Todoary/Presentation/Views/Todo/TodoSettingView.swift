//
//  TodoSettingViewController+Layout.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/23.
//

import UIKit

class TodoSettingView: BaseView {
    
    
    let collectionView = UICollectionView(frame: .init(), collectionViewLayout: LeftAlignedCollectionViewFlowLayout()).then{
        $0.showsVerticalScrollIndicator = false
        $0.register(TodoCategoryCell.self, forCellWithReuseIdentifier: TodoCategoryCell.cellIdentifier)
    }
    
    let todo = UITextField().then{
        $0.placeholder = "투두이름"
        $0.font = UIFont.nbFont(type: .body2)
        $0.setPlaceholderColor(.todoaryGrey)
    }
    
    let todoBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let dateTitle = UILabel().then{
        $0.text = "날짜"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let date = UIButton().then{
        $0.setTitle("2022년 7월 20일", for: .normal)
        $0.addLetterSpacing(spacing: 0.28)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body2)
        $0.titleLabel?.textAlignment = .right
    }
    
    let dateBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let alarm = UILabel().then{
        $0.text = "알람"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    var time = UIButton().then{
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.setTitle("AM 8:00", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addLetterSpacing(spacing: 0.28)
        $0.titleLabel?.font = UIFont.nbFont(type: .body2)
        $0.titleLabel?.textAlignment = .right
    }
    
    let alarmSwitch = UISwitch()
    
    let alarmBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let category = UILabel().then{
        $0.text = "카테고리"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let plusBtn = UIButton().then{
        $0.setImage(UIImage(named: "categoryadd"), for: .normal)
    }
    
    let categoryBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    override func hierarchy(){
        
        self.addSubview(todo)
        self.addSubview(todoBorderLine)
        
        self.addSubview(dateTitle)
        self.addSubview(date)
        self.addSubview(dateBorderLine)

        self.addSubview(alarm)
        self.addSubview(time)
        self.addSubview(alarmSwitch)
        self.addSubview(alarmBorderLine)
        
        self.addSubview(category)
        self.addSubview(plusBtn)
        self.addSubview(collectionView)
        self.addSubview(categoryBorderLine)

    }
    
    override func layout(){
        
        todo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(16)
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

