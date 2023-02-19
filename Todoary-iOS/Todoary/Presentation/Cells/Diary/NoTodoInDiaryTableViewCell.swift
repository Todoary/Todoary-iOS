//
//  NoTodoInDiaryTableViewCell.swift
//  Todoary
//
//  Created by 박소윤 on 2023/02/19.
//

import Foundation

class NoTodoInDiaryTableViewCell: BaseTableViewCell {
    
    private let backgroundShadowView = ShadowView(cornerRadius: 20)
    private let checkBox = UIButton().then{
        $0.setImage(Image.todoCheckEmpty, for: .normal)
    }
    private let titleLabel = UILabel().then{
        $0.text = "오늘은 투두가 없는 널널한 날이네요"
        $0.textColor = .black
        $0.setTypoStyleWithSingleLine(typoStyle: .bold15_18)
    }

    override func hierarchy() {
        
        super.hierarchy()
        
        baseView.addSubview(backgroundShadowView)
        
        backgroundShadowView.addSubview(checkBox)
        backgroundShadowView.addSubview(titleLabel)
   
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
        
        checkBox.snp.makeConstraints{
            $0.width.height.equalTo(24)
            $0.leading.equalToSuperview().offset(19)
            $0.top.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().offset(-18)
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(checkBox.snp.trailing).offset(13)
            $0.centerY.equalTo(checkBox)
        }
    }
}
