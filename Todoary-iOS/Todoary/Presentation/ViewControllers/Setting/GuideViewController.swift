//
//  GuideViewController.swift
//  Todoary
//
//  Created by 송채영 on 2023/02/21.
//

import Foundation
import SnapKit
import UIKit
import Then

class GuideViewController : BaseViewController {
    
    let mainView = GuideView()
    
    var onboardingImg = [UIImage(named: "onboarding1"), UIImage(named: "onboarding2"), UIImage(named: "onboarding3"), UIImage(named: "onboarding4")]
    
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        style()
        layout()
        initialize()
        
    }
    
    //MARK: - BaseProtocol
    
    override func style() {
        super.style()
        
        navigationTitle.text = "Todoary 가이드"
    }
    
    override func layout() {
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        
        self.view.layoutIfNeeded()
        
        mainView.onboardingImgScrollView.delegate = self
        
        setupScreens()
    }
    
    
    //MARK: - Actions
    
    private func setupScreens() {
        
        for index in 0...3 {
            
            let imgView = UIImageView().then {
                $0.image = onboardingImg[index]
            }
            
            mainView.onboardingImgScrollView.addSubview(imgView)
            
            imgView.snp.makeConstraints{ make in
                make.top.bottom.equalToSuperview()
                make.leading.equalToSuperview().offset(screenSize.width * CGFloat(index))
                make.trailing.equalToSuperview().offset(-(screenSize.width * CGFloat(3 - index)))
                make.width.equalTo(screenSize.width)
                make.height.equalToSuperview()
            }
            mainView.onboardingImgScrollView.contentSize.width = screenSize.width * CGFloat(index + 1)
        }
        
    }
}

extension GuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ onboardingImgScrollView: UIScrollView) {
        mainView.onboardingPagecontrol.currentPage = Int(floor(onboardingImgScrollView.contentOffset.x / screenSize.width))

    }
}


 

