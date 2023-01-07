//
//  SummaryBottomSheetViewController+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/02.
//

import UIKit

extension SummaryBottomViewController{
    
    func setInitView(){
        
        tableView = UITableView().then{
            
            $0.delegate = self
            $0.dataSource = self
            
            $0.separatorStyle = .none
            $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            $0.register(TodoListTitleCell.self, forCellReuseIdentifier: TodoListTitleCell.cellIdentifier)
            $0.register(TodoBannerCell.self, forCellReuseIdentifier: TodoBannerCell.cellIdentifier)
            $0.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.cellIdentifier)
            $0.register(DiaryTitleCell.self, forCellReuseIdentifier: DiaryTitleCell.cellIdentifier)
            $0.register(DiaryCell.self, forCellReuseIdentifier: DiaryCell.cellIdentifier)
            $0.register(DiaryBannerCell.self, forCellReuseIdentifier: DiaryBannerCell.cellIdentifier)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellWillMoveToOriginalPosition))
            $0.addGestureRecognizer(tapGesture)
        }
        
        //카테고리 컬렉션뷰 (투두간단설정화면)
        collectionView = UICollectionView(frame: .init(), collectionViewLayout: .init()).then{
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = CGFloat(8)
            
            $0.collectionViewLayout = flowLayout
            $0.isHidden = true
            $0.delegate = self
            $0.dataSource = self
            $0.showsHorizontalScrollIndicator = false
            $0.isUserInteractionEnabled = true
            $0.contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
            
            $0.register(TodoCategoryCell.self, forCellWithReuseIdentifier: TodoCategoryCell.cellIdentifier)
        }
        
        self.todoTf.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didShowKeyboardNotification(_:)),
                                               name: UIResponder.keyboardWillShowNotification ,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didHideKeyboardNotification(_:)),
                                               name: UIResponder.keyboardWillHideNotification ,
                                               object: nil)
    }
    
    func setUpView(){
        self.view.addSubview(sheetLine)
        self.view.addSubview(tableView)
//        self.view.addSubview(addButton)
        
        self.view.addSubview(todoEasySettingView)
        self.view.addSubview(todoTf)
        self.view.addSubview(collectionView)
        self.view.bringSubviewToFront(collectionView)
    }
    
    func setUpConstraint(){
        
        todoEasySettingView.snp.makeConstraints{ make in
            make.height.equalTo(118)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        todoTf.snp.makeConstraints{ make in
            make.height.equalTo(45)
            make.top.equalTo(self.todoEasySettingView.snp.top).offset(17)
            make.leading.equalTo(todoEasySettingView).offset(32)
            make.trailing.equalTo(todoEasySettingView).offset(-31)
            make.bottom.equalTo(todoEasySettingView.snp.bottom).offset(-56)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.height.equalTo(26)
            make.top.equalTo(todoTf.snp.bottom).offset(14)
            make.leading.equalTo(todoEasySettingView)
            make.trailing.equalTo(todoEasySettingView.snp.trailing)
            make.bottom.equalTo(todoEasySettingView.snp.bottom).offset(-16)
        }
        
        sheetLine.snp.makeConstraints{ make in
            make.width.equalTo(46)
            make.height.equalTo(5)
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(172)
            make.trailing.equalToSuperview().offset(-172)
        }
        
        tableView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
//
//        addButton.snp.makeConstraints{ make in
//            make.width.height.equalTo(70)
//            make.bottom.equalToSuperview().offset(-52.52)
//            make.trailing.equalToSuperview().offset(-27)
//        }
    }
}

extension SummaryBottomViewController: UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let controller: UISheetPresentationController = .init(presentedViewController: presented, presenting: presenting)
        
        let detent1: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test1", constant: Const.Device.DEVICE_HEIGHT - (519 + 41)) //519 + 41
        let detent2: UISheetPresentationController.Detent = ._detent(withIdentifier: "Test2", constant: Const.Device.DEVICE_HEIGHT - (95 + 41) ) //790 - 41
        
        let detentIdentifier :UISheetPresentationController.Detent.Identifier = UISheetPresentationController.Detent.Identifier(rawValue: "Test2")
        
        controller.detents = [detent1, detent2]
        controller.preferredCornerRadius = 30
        controller.largestUndimmedDetentIdentifier = detentIdentifier
        controller.prefersScrollingExpandsWhenScrolledToEdge = false
        
        return controller
    }
    
    func setUpSheetVC(){
        isModalInPresentation = true
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
}
