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
    
    var cellData : TodoResultModel!
    var delegate: DiaryTodoCellDelegate?
    
    private let backgroundShadowView = ShadowView(cornerRadius: 20)
    lazy var checkBox = UIButton().then{
        $0.setImage(Image.todoCheckEmpty, for: .normal)
        $0.setImage(Image.todoCheck, for: .selected)
        $0.addTarget(self, action: #selector(checkBoxBtnDidClicked), for: .touchUpInside)
    }
    
    let titleLabel = UILabel().then{
        $0.textColor = .black
        $0.setTypoStyleWithSingleLine(typoStyle: .bold15_18)
    }
    
    lazy var categoryButton = CategoryTag.generateForCategoryTodo()
    
    lazy var alarmImage = UIImageView().then{
        $0.image = Image.notifications
    }
    
    let timeLabel = UILabel().then{
        $0.textColor = .timeColor
        $0.setTypoStyleWithSingleLine(typoStyle: .medium13)
    }

    override func hierarchy() {
        super.hierarchy()
        
        self.contentView.addSubview(backgroundShadowView)
        
        self.backgroundShadowView.addSubview(checkBox)
        self.backgroundShadowView.addSubview(titleLabel)
        self.backgroundShadowView.addSubview(timeLabel)
        self.backgroundShadowView.addSubview(categoryButton)
   
    }
    
    override func layout() {
        
        super.layout()
        
        self.contentView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(75)
            make.top.equalToSuperview().offset(7.5)
            make.bottom.equalToSuperview().offset(-7.5)
        }
        
        backgroundShadowView.snp.makeConstraints{ make in
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
            make.centerY.equalToSuperview()
            make.trailing.equalTo(timeLabel.snp.leading).offset(-7)
        }
    }
    
    private func setUpViewByCase(){
        
        if(cellData.isAlarmEnabled){
            
            self.backgroundShadowView.addSubview(alarmImage)
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
    
    @objc private func checkBoxBtnDidClicked(){
        delegate?.requestPatchTodoCheckStatus(cell: self)
    }
    
    func bindingData(_ todo: TodoResultModel){
        
    }
}
