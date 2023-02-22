//
//  NoTodoTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/04.
//

import UIKit

class NoTodoInCategoryTableViewCell: BaseTableViewCell {
    
    private lazy var checkBox = UIButton().then{
        $0.setImage(Image.todoCheckEmpty, for: .normal)
    }
    
    private let backgroundShadowView = ShadowView(cornerRadius: 20)
    private let titleLabel = UILabel().then{
        $0.text  = "카테고리에 새로운 투두를 추가해보세요"
        $0.textColor = .black
        $0.numberOfLines = 1
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
            $0.height.equalTo(88+20)
        }
        backgroundShadowView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-30)
        }

        checkBox.snp.makeConstraints{
            $0.width.height.equalTo(22)
            $0.leading.equalToSuperview().offset(19)
            $0.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkBox.snp.trailing).offset(9)
            $0.trailing.equalToSuperview().offset(-18)
        }
        
    }
    
}
