//
//  DiaryViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/30.
//

import Foundation
import UIKit
import SnapKit


extension DiaryViewController {
    
    func setUpView(){
        
        self.view.addSubview(registerBtn)
        self.view.addSubview(todaysDate)
        
        self.view.addSubview(diaryLine)
        self.view.addSubview(diaryTitle)
        self.view.addSubview(textView)

    }
    
    
    func setUpConstraint(){
        
        registerBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.trailing.equalToSuperview().offset(-21)
            make.width.equalTo(35)
            make.height.equalTo(22)
        }
        
        todaysDate.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(101)
            make.leading.equalToSuperview().offset(32)
            make.width.equalTo(84)
            make.height.equalTo(19)
        }
        
        diaryLine.snp.makeConstraints{ make in
            make.top.equalTo(todaysDate.snp.bottom).offset(176)
            make.leading.equalToSuperview().offset(31)
            make.centerX.equalToSuperview()
            make.width.equalTo(328)
            make.height.equalTo(1)
            
        }
        
        diaryTitle.snp.makeConstraints{ make in
            make.top.equalTo(diaryLine.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(29)
        }
        
        //diaryText
        textView.snp.makeConstraints{ make in
            make.top.equalTo(diaryTitle.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(29)
            make.trailing.equalToSuperview().offset(-29)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
}
