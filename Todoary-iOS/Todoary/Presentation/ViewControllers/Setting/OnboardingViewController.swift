//
//  OnboardingViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/08/23.
//

import Foundation
import SnapKit
import UIKit
import Then

class OnboardingViewController : UIViewController {
    
    let mainView = OnboardingView()
    
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
    
    func style() {
    }
    
    func layout() {
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func initialize() {
        
        self.view.layoutIfNeeded()
        
        mainView.onboardingImgScrollView.delegate = self
        
        mainView.confirmBtn.addTarget(self, action: #selector(confirmBtnDidTap), for: .touchUpInside)
        
        setupScreens()
    }
    
    
    //MARK: - Actions
    
    @objc func confirmBtnDidTap(_ sender: UIButton){
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
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

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ onboardingImgScrollView: UIScrollView) {
        mainView.onboardingPagecontrol.currentPage = Int(floor(onboardingImgScrollView.contentOffset.x / screenSize.width))
        
        setbtn()
    }
    
    func setbtn() {
        if mainView.onboardingPagecontrol.currentPage == 3 {
            mainView.confirmBtn.isHidden = false
            mainView.confirmBtn.isEnabled = true
        } else {
            mainView.confirmBtn.isHidden = true
            mainView.confirmBtn.isEnabled = false
        }
    }
}


 
