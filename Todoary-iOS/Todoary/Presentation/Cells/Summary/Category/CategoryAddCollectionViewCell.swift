//
//  CategoryAddCollectionViewCell.swift
//  Todoary
//
//  Created by 박소윤 on 2023/02/03.
//

import Foundation

class CategoryAddCollectionViewCell: BaseCollectionViewCell{
    
    static let cellSize = CGSize(width: 25.91, height: 25.91)
    
    private let plusImage = UIImageView().then{
        $0.image = Image.categoryPlus
    }
    
    override func hierarchy() {
        super.hierarchy()
        baseView.addSubview(plusImage)
    }
    
    override func layout() {
        super.layout()
        plusImage.snp.makeConstraints{
            $0.width.height.equalTo(CategoryAddCollectionViewCell.cellSize.width)
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
