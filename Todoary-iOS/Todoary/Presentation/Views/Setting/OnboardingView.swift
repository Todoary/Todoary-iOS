//
//  OnboardingView.swift
//  Todoary
//
//  Created by 송채영 on 2023/02/21.
//

import Foundation
import SnapKit


class OnboardingView: BaseView{
    
    //MARK: - UIComponenets

    let onboardingPagecontrol = UIPageControl().then {
        $0.currentPage = 0
        $0.numberOfPages = 4
        $0.pageIndicatorTintColor = UIColor (red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        $0.currentPageIndicatorTintColor = UIColor.buttonColor
    }
    
    let onboardingImgScrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alwaysBounceVertical = false
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.bounces = false
    }
    
    let confirmBtn = UIButton().then {
        $0.isEnabled = false
        $0.isHidden = true
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
    }
    
    override func hierarchy(){
        
        self.addSubview(onboardingImgScrollView)
        self.addSubview(onboardingPagecontrol)
        self.addSubview(confirmBtn)
        
        

       
    }
    
    
    override func layout(){
        let screenSize = UIScreen.main.bounds
        
        onboardingImgScrollView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(102)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-131)
            make.height.equalTo(611)
            make.width.equalTo(screenSize.width * 4)
        }
        
        onboardingPagecontrol.snp.makeConstraints{ make in
            make.top.equalTo(onboardingImgScrollView.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(10)
        }
        
        confirmBtn.snp.makeConstraints{ make in
            make.top.equalTo(onboardingPagecontrol.snp.bottom).offset(21)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(52)
        }
        
    }
}

        
