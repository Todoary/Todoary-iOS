//
//  DiaryTabelViewCell.swift
//  Todoary
//
//  Created by 예리 on 2022/07/30.
//

import Foundation
import SnapKit
import UIKit

protocol DiaryTodoCellDelegate{
    func requestPatchTodoCheckStatus(cell: TodoInDiaryTableViewCell)
}

class TodoInDiaryTableViewCell: BaseTableViewCell {
    
    var delegate: DiaryTodoCellDelegate?
    
    private let backgroundShadowView = DiaryShadowView()
    lazy var checkBox = UIButton().then{
        $0.setImage(Image.todoCheckEmpty, for: .normal)
        $0.setImage(Image.todoCheck, for: .selected)
        $0.addTarget(self, action: #selector(checkBoxBtnDidClicked), for: .touchUpInside)
    }
    private let titleLabel = UILabel().then{
        $0.textColor = .black
        $0.setTypoStyleWithSingleLine(typoStyle: .bold15_18)
    }
    private lazy var categoryButton = CategoryTag.generateForCategoryTodo()
    private let timeLabel = UILabel().then{
        $0.textColor = .timeColor
        $0.setTypoStyleWithSingleLine(typoStyle: .medium13)
    }

    override func hierarchy() {
        
        super.hierarchy()
        
        baseView.addSubview(backgroundShadowView)
        
        backgroundShadowView.addSubview(checkBox)
        backgroundShadowView.addSubview(titleLabel)
        backgroundShadowView.addSubview(timeLabel)
        backgroundShadowView.addSubview(categoryButton)
    }
    
    override func layout() {
        
        super.layout()
        
        baseView.snp.makeConstraints{
            $0.height.equalTo(75)
        }
        backgroundShadowView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(7.5)
            $0.leading.trailing.equalToSuperview().inset(31)
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
            make.trailing.equalToSuperview().inset(145)
        }
        timeLabel.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalToSuperview().offset(23.4)
            make.bottom.equalToSuperview().offset(-22.46)
        }
        categoryButton.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(timeLabel.snp.leading).offset(-7)
        }
    }
    
    @objc private func checkBoxBtnDidClicked(){
        checkBox.isEnabled = false
        delegate?.requestPatchTodoCheckStatus(cell: self)
    }
    
    func bindingData(_ todo: TodoResultModel){
        titleLabel.text = todo.title
        timeLabel.text = todo.convertTime
        checkBox.isSelected = todo.isChecked
        categoryButton.bindingData(title: todo.categoryTitle, color: todo.color)
    }
}
