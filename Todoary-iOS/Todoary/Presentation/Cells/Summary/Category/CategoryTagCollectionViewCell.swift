//
//  CategoryButton.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryTagCollectionViewCell: BaseCollectionViewCell{
    
    static let cellIdentifier = "CategoryTagCollectionViewCell"
    
    private let tagLabel = CategoryTag.generateForDefault()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    override func hierarchy() {
        super.hierarchy()
        self.baseView.addSubview(tagLabel)
    }
    
    override func layout() {
        super.layout()
        tagLabel.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        tagLabel.initialize()
    }
    
    func bindingData(title: String, color: Int){
        tagLabel.bindingData(title: title, color: color)
    }
    
    func setSelectState(){
        tagLabel.setSelectState()
    }
    
    func setDeselectState(){
        tagLabel.setDeselectState()
    }
}
