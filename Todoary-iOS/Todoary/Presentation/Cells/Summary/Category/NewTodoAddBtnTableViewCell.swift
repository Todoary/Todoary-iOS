//
//  NewTodoAddBtnTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/24.
//

import UIKit

class NewTodoAddBtnTableViewCell: BaseTableViewCell {
    
    private let backgroundShadowView = ShadowView(cornerRadius: 20)
    
    private let addImage = UIImageView().then{
        $0.image = Image.categoryPlus
    }
    
    override func hierarchy() {
        super.hierarchy()
        baseView.addSubview(backgroundShadowView)
        backgroundShadowView.addSubview(addImage)
    }
    
    override func layout() {
        
        super.layout()
        baseView.snp.updateConstraints{
            $0.leading.trailing.equalToSuperview().inset(31)
        }
        backgroundShadowView.snp.makeConstraints{
            $0.height.equalTo(47)
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        addImage.snp.makeConstraints{
            $0.width.height.equalTo(25)
            $0.centerY.centerX.equalToSuperview()
        }
    }
}

protocol MoveViewController{
    func moveToViewController()
}
