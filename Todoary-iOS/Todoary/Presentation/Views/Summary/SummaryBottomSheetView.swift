//
//  SummaryBottomSheetView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/02.
//

import UIKit

class SummaryBottomSheetView: BaseView{
    
    let sheetLine = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5/2
    }
    
    let summaryTableView = UITableView().then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        $0.register(TodoTitleInSummaryTableViewCell.self, forCellReuseIdentifier: TodoTitleInSummaryTableViewCell.cellIdentifier)
        $0.register(TodoBannerInSummaryTableViewCell.self, forCellReuseIdentifier: TodoBannerInSummaryTableViewCell.cellIdentifier)
        $0.register(TodoInSummaryTableViewCell.self, forCellReuseIdentifier: TodoInSummaryTableViewCell.cellIdentifier)
        $0.register(DiaryInSummaryTableViewCell.self, forCellReuseIdentifier: DiaryInSummaryTableViewCell.cellIdentifier)
        $0.register(DiaryTitleInSummaryTableViewCell.self, forCellReuseIdentifier: DiaryTitleInSummaryTableViewCell.cellIdentifier)
        $0.register(DiaryBannerInSummaryTableViewCell.self, forCellReuseIdentifier: DiaryBannerInSummaryTableViewCell.cellIdentifier)
    }
    
    override func hierarchy(){
        self.addSubview(sheetLine)
        self.addSubview(summaryTableView)
    }
    
    override func layout(){
        sheetLine.snp.makeConstraints{ make in
            make.width.equalTo(46)
            make.height.equalTo(5)
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(172)
            make.trailing.equalToSuperview().offset(-172)
        }
        
        summaryTableView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
    }
}

extension SummaryBottomSheetViewController: UIViewControllerTransitioningDelegate{
    
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
