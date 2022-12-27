//
//  CategoryView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/27.
//

import UIKit

class CategoryView: UIView, BaseViewProtocol {
    
    lazy var trashButton = UIButton().then{
        $0.setImage(UIImage(named: "category_trash"), for: .normal)
    }

    let categoryCollectionView : UICollectionView = UICollectionView(frame: .init(), collectionViewLayout: .init()).then{
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = CGFloat(8)
        
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = flowLayout
        $0.contentInset = UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 0)

        $0.register(CategoryPlusButtonCell.self, forCellWithReuseIdentifier: CategoryPlusButtonCell.cellIdentifier)
        $0.register(CategoryButtonCollectionViewCell.self, forCellWithReuseIdentifier: CategoryButtonCollectionViewCell.cellIdentifier)
    }

    let todoTableView = UITableView().then{
        
        $0.separatorStyle = .none
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        $0.register(CategoryTodoTableViewCell.self, forCellReuseIdentifier: CategoryTodoTableViewCell.cellIdentifier)
        $0.register(NoTodoTableViewCell.self, forCellReuseIdentifier: NoTodoTableViewCell.cellIdentifier)
        $0.register(NewTodoAddBtnTableViewCell.self, forCellReuseIdentifier: NewTodoAddBtnTableViewCell.cellIdentifier)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hierarchy() {
        self.addSubview(categoryCollectionView)
        self.addSubview(todoTableView)
        
        self.addSubview(trashButton)
    }
    
    func layout() {
        trashButton.snp.makeConstraints{ make in
            make.width.equalTo(61)
            make.height.equalTo(55)
            make.top.equalToSuperview().offset(42)
            make.trailing.equalToSuperview().offset(-18.95)
        }
        
        categoryCollectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(106)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(26)
        }
        
        todoTableView.snp.makeConstraints{ make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
