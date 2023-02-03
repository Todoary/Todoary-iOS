//
//  CategoryAddCollectionViewCell.swift
//  Todoary
//
//  Created by 박소윤 on 2023/02/03.
//

import Foundation

class CategoryAddCollectionViewCell: UICollectionViewCell{
    
    static let cellIdentifier = "CategoryPlusButtonCell"
    
    let plusImage = UIImageView().then{
        $0.image = UIImage(named: "category_plus")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(plusImage)
        
        plusImage.snp.makeConstraints{ make in
            make.width.height.equalTo(25.91)
            make.leading.top.bottom.equalToSuperview()
        }
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
