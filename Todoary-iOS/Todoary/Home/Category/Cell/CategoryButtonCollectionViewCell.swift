//
//  CategoryButton.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/23.
//

import UIKit

class CategoryButtonCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let cellIdentifier = "categoryButtonCell"
    
    var viewController: CategoryViewController!
    
    var categoryData : GetCategoryResult!
    
    var categoryColor: UIColor!
    
    //MARK: - UI
    
    lazy var categoryBtn = UIButton().then{
        $0.setTitleColor(.white, for: .selected)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 14, weight: .bold)
        $0.addLetterSpacing(spacing: 0.28)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(categoryButtonDidClicked(_:)), for: .touchUpInside)
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: 4, right:16)
        $0.layer.cornerRadius = 26/2
    }
   
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        categoryBtn.isSelected = false
        categoryBtn.setTitle("", for: .normal)
        categoryBtn.setTitleColor(.transparent, for: .normal)
        categoryBtn.layer.borderColor = UIColor.transparent.cgColor
        categoryBtn.backgroundColor = .transparent
    }
    
    //MARK: - Method
    
    func setBtnAttribute(){
        
        self.categoryColor = UIColor.categoryColor[self.categoryData.color]
        
        categoryBtn.setTitle(categoryData.title, for: .normal)
        
        categoryBtn.layer.borderColor = self.categoryColor.cgColor
        
        categoryBtn.setTitleColor(categoryColor, for: .normal)
        categoryBtn.setTitleColor(.white, for: .selected)
        
        buttonIsNotSelected()
    }
    
    func buttonIsSelected(){
        categoryBtn.isSelected = true
        
        categoryBtn.backgroundColor = self.categoryColor
    }
    
    func buttonIsNotSelected(){
        categoryBtn.isSelected = false
        
        categoryBtn.backgroundColor = .white
    }
    
    //MARK: - ACTION
    
    @objc
    func categoryButtonDidClicked(_ sender: UIButton){
        if(!categoryBtn.isSelected){
            
            guard let tableView = self.superview as? UICollectionView else{return}
            let index = tableView.indexPath(for: self)
            TodoGetByCategoryDataManager().get(indexPath: index!, viewController: self.viewController, categoryId: categoryData.id)
        }
    }
}

class CategoryPlusButtonCell: UICollectionViewCell{
    
    static let cellIdentifier = "categoryPlusCell"
    
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
