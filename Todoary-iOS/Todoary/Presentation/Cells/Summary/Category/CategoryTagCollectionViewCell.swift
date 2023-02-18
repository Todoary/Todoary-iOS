//
//  CategoryButton.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryTagCollectionViewCell: BaseCollectionViewCell{

    private let tagLabel = CategoryTag.generateForDefault()
    
    override func prepareForReuse() {
        tagLabel.initialize()
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
