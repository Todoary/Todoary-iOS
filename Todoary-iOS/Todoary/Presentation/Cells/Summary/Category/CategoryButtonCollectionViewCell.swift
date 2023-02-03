//
//  CategoryButton.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryButtonCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    static let cellIdentifier = "CategoryButtonCollectionViewCell"

    var categoryData : CategoryModel!
    var categoryColor: UIColor!
    
    //MARK: - UI
    
    let categoryButton = CategoryTag.generateForDefault()
//    lazy var categoryBtn = UIButton().then{
//        $0.setTitleColor(.white, for: .selected)
//        $0.titleLabel?.font = UIFont.nbFont(ofSize: 14, weight: .bold)
//        $0.addLetterSpacing(spacing: 0.28)
//        $0.titleLabel?.textAlignment = .center
//        $0.layer.borderWidth = 1
//        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 4, right: 0)
//        $0.layer.cornerRadius = 26/2
//        $0.isUserInteractionEnabled = false
//    }
   
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        /*
        self.contentView.addSubview(categoryBtn)
        
        self.snp.makeConstraints{ make in
            make.width.height.equalTo(categoryBtn)
        }
        self.contentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        categoryBtn.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
         */
    }
    
    override func hierarchy() {
        super.hierarchy()
        self.baseView.addSubview(categoryButton)
    }
    
    override func layout() {
        super.layout()
        categoryButton.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        categoryButton.initialize()
        /*
        categoryBtn.setTitle("", for: .normal)
        categoryBtn.setTitleColor(.transparent, for: .normal)
        categoryBtn.layer.borderColor = UIColor.transparent.cgColor
        categoryBtn.backgroundColor = .transparent
         */
    }
    
    //MARK: - Method
    
//    func setBtnAttribute(){
//
//        self.categoryColor = UIColor.categoryColor[self.categoryData.color]
//
//        categoryBtn.setTitle(categoryData.title, for: .normal)
//
//        categoryBtn.layer.borderColor = self.categoryColor.cgColor
//
//        categoryBtn.setTitleColor(categoryColor, for: .normal)
//        categoryBtn.setTitleColor(.white, for: .selected)
//
//        buttonIsNotSelected()
//
//        print("버튼 글자수", categoryBtn.title(for: .normal), categoryBtn.title(for: .normal)!.count)
//    }
    
//    func buttonIsSelected(){
//        categoryBtn.isSelected = true
//        categoryBtn.backgroundColor = self.categoryColor
//    }
//
//    func buttonIsNotSelected(){
//        categoryBtn.isSelected = false
//        categoryBtn.backgroundColor = .white
//    }
}

class CategoryPlusButtonCell: UICollectionViewCell{
    
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
