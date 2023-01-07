//
//  TodoCategoryCell.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/31.
//

import UIKit

class TodoCategoryCell: UICollectionViewCell {
    
    static let cellIdentifier = "todoCategoryCell"
    
    var viewController: TodoSettingViewController!
    
    lazy var categoryLabel = cellPaddingLabel().then{
        $0.textColor = .white
        $0.font = UIFont.nbFont(ofSize: 14, weight: .bold)
        $0.addLetterSpacing(spacing: 0.28)
        $0.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 26/2
        $0.layer.masksToBounds = true
    }
    
    var categoryColor : UIColor!
   
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(categoryLabel)
        
        self.snp.makeConstraints{ make in
            make.width.height.equalTo(categoryLabel)
        }
        self.contentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBtnAttribute(title:String,color: UIColor){
        
        categoryColor = color
        
        categoryLabel.text = title
        categoryLabel.textColor = categoryColor
        
    }
}

class cellPaddingLabel: UILabel {
    var padding = UIEdgeInsets(top: 5, left: 10, bottom: 4, right:10)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
            var contentSize = super.intrinsicContentSize
            contentSize.height += padding.top + padding.bottom
            contentSize.width += padding.left + padding.right
            
            return contentSize
        }
}
