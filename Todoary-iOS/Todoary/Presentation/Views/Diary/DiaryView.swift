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
    
    let todaysDate = UILabel().then{
        $0.setTypoStyleWithSingleLine(typoStyle: .bold16_19)
        $0.textColor = .black
    }
    let todoTableView = UITableView().then{
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        $0.register(cellType: TodoInDiaryTableViewCell.self)
        $0.register(cellType: NoTodoInDiaryTableViewCell.self)
    }
    let borderLine =  UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let diaryTitle = UITextField().then{
        $0.placeholder = "오늘의 일기 제목"
        $0.font = UIFont.nbFont(ofSize: 18, weight: .bold)
        $0.setPlaceholderColor(.silver_225)
        $0.addLeftPadding(padding: 5.3)
        $0.addLetterSpacing(spacing: 0.32)
        $0.borderStyle = .none
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
        self.addSubview(borderLine)
        self.addSubview(diaryTitle)
        self.addSubview(textView)
    }
    
    override func layout() {
        
        todaysDate.snp.makeConstraints{
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(32)
        }
        todoTableView.snp.makeConstraints {
            $0.top.equalTo(todaysDate.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(167)
        }
        
        borderLine.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-31)
            $0.bottom.equalTo(todoTableView)
            $0.height.equalTo(1)
        }
        
        diaryTitle.snp.makeConstraints{
            $0.top.equalTo(borderLine.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(29)
        }
        
        textView.snp.makeConstraints{
            $0.top.equalTo(diaryTitle.snp.bottom).offset(17)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-28)
        }
    }

}
