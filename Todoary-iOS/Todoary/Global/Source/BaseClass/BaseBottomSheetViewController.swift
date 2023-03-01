//
//  BaseBottomSheetViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/31.
//

import UIKit

enum BottomSheetType: CGFloat{
    case category = 327
}

class BaseBottomSheetViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //MARK: - Properties
    
    private let type: BottomSheetType!
    
    init(type: BottomSheetType){
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        style()
        layout()
        initialize()
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let controller: UISheetPresentationController = .init(presentedViewController: presented, presenting: presenting)
        
        let constant = type.rawValue * Const.Device.DEVICE_HEIGHT / 844
        
        let detent: UISheetPresentationController.Detent = ._detent(withIdentifier: "Detent1", constant: constant)
    
        controller.detents = [detent]
        controller.preferredCornerRadius = 30
        controller.prefersGrabberVisible = false
        
        return controller
    }
    
    func style(){
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func initialize() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    func layout() {}
    
    func show(in viewController: UIViewController) -> Self{
        self.loadViewIfNeeded()
        viewController.present(self, animated: true)
        return self
    }
    
    @objc func viewDidTapped(){
        self.view.endEditing(true)
    }

}
