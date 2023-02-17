//
//  CategoryView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/27.
//

import UIKit

class CategoryView: BaseView {

    let categoryCollectionView : UICollectionView = UICollectionView(frame: .init(), collectionViewLayout: .init()).then{
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = CGFloat(8)
        
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = flowLayout
        $0.contentInset = UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 0)

        $0.register(CategoryAddCollectionViewCell.self, forCellWithReuseIdentifier: CategoryAddCollectionViewCell.cellIdentifier)
        $0.register(CategoryTagCollectionViewCell.self, forCellWithReuseIdentifier: CategoryTagCollectionViewCell.cellIdentifier)
    }

    let todoTableView = UITableView().then{
        
        $0.separatorStyle = .none
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.contentInset = UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0)
        
        $0.register(CategoryTodoTableViewCell.self, forCellReuseIdentifier: CategoryTodoTableViewCell.cellIdentifier)
        $0.register(NoTodoInCategoryTableViewCell.self, forCellReuseIdentifier: NoTodoInCategoryTableViewCell.cellIdentifier)
        $0.register(NewTodoAddBtnTableViewCell.self, forCellReuseIdentifier: NewTodoAddBtnTableViewCell.cellIdentifier)
        
    }
    
    override func hierarchy() {
        self.addSubview(categoryCollectionView)
        self.addSubview(todoTableView)
    }
    
    override func layout() {
        
        categoryCollectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(11)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(26)
        }
        
        todoTableView.snp.makeConstraints{ make in
            make.top.equalTo(categoryCollectionView.snp.bottom)
//                .offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
