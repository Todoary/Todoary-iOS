//
//  DiaryTestView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/30.
//

import UIKit

class DiaryView: BaseView {
    
    static let textViewPlaceHolder = "오늘의 일기를 작성해보세요!"
    
    let toolbar = DiaryToolbar().then{
        $0.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 92.0)
    }
    
    let todoTableView = UITableView().then{
        $0.showsVerticalScrollIndicator = false
        $0.register(DiaryTabelViewCell.self, forCellReuseIdentifier: DiaryTabelViewCell.cellIdentifier)
    }
    
    let todaysDate = UILabel().then{
        $0.font = UIFont.nbFont(ofSize: 16, weight: .bold)
        $0.addLetterSpacing(spacing: 0.32)
        $0.textColor = .black
    }
    
    let diaryTitle = UITextField().then{
        $0.placeholder = "오늘의 일기 제목"
        $0.font = UIFont.nbFont(ofSize: 18, weight: .bold)
        $0.setPlaceholderColor(.silver_225)
        $0.addLeftPadding(padding: 5.3)
        $0.addLetterSpacing(spacing: 0.32)
        $0.borderStyle = .none
    }
    
    
    let diaryLine =  UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let textView = UITextView().then{
        $0.text = DiaryView.textViewPlaceHolder
        $0.setTextWithLineHeight(spaing: 25)
        $0.textColor = .silver_225
        $0.font = UIFont.nbFont(ofSize: 15, weight: .medium)
    }
    
    override func style() {
        textView.inputAccessoryView = toolbar
    }
    
    override func hierarchy() {
        
        self.addSubview(todoTableView)
        
        self.addSubview(todaysDate)
        
        self.addSubview(diaryLine)
        self.addSubview(diaryTitle)
        self.addSubview(textView)
    }
    
    override func layout() {

        todoTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
                make.leading.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalTo(161)
                make.centerX.equalToSuperview()
           }
        
        todaysDate.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(6)
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
