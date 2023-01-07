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


    var onboardingImg = [UIImage(named: "onboarding1"), UIImage(named: "onboarding2"), UIImage(named: "onboarding3"), UIImage(named: "onboarding4")]

    let onboardingPagecontrol = UIPageControl()
    
    let onboardingImgScrollView = UIScrollView()

    let confirmBtn = UIButton().then {
        $0.isEnabled = false
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .buttonColor
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
        $0.isHidden = true
//        $0.addTarget(self, action: #selector(passWordChangeBtnDidTap), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.view.addSubview(onboardingImgScrollView)
        onboardingImgScrollView.backgroundColor = .black
        
        onboardingImgScrollView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(102)
            make.height.equalTo(611)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(onboardingPagecontrol)
        onboardingPagecontrol.backgroundColor = .black
        
        onboardingPagecontrol.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-119)
            make.height.equalTo(9)
            make.width.equalTo(63)
            make.centerX.equalToSuperview()
        }
        
        onboardingPagecontrol.pageIndicatorTintColor = UIColor (
                   red: 217/255,
                   green: 217/255,
                   blue: 217/255,
                   alpha: 1)
               //현재 페이지 표시 색상
        onboardingPagecontrol.currentPageIndicatorTintColor = UIColor.buttonColor
//        onboardingPagecontrol.currentPage = 0
//        onboardingPagecontrol.isUserInteractionEnabled = false
        onboardingPagecontrol.numberOfPages = onboardingImg.count

        onboardingImgScrollView.delegate = self
        onboardingImgScrollView.isPagingEnabled = true
        onboardingImgScrollView.isScrollEnabled = true

        setupScreens()
        setbtn()
    }
    
    private func setupScreens() {
        
        for index in 0..<onboardingImg.count {
            
            let imgView = UIImageView()
            let positionX = self.view.frame.width * CGFloat(index)
            
            imgView.frame = CGRect(x: positionX, y: 0, width: onboardingImgScrollView.bounds.width, height: onboardingImgScrollView.bounds.height)
            imgView.image = onboardingImg[index]
            onboardingImgScrollView.addSubview(imgView)
            onboardingImgScrollView.contentSize.width = imgView.frame.width * CGFloat(index + 1)
            
        }
    }
    
    private func selectedPage(currentPage : Int) {
        onboardingPagecontrol.currentPage = currentPage
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ onboardingImgScrollView: UIScrollView) {
        let value = onboardingImgScrollView.contentOffset.x/onboardingImgScrollView.frame.size.width
        selectedPage(currentPage: Int(round(value)))
        
        setbtn()
    }
    
    func setbtn() {
        if onboardingPagecontrol.currentPage == 3 {
            confirmBtn.isHidden = false
        } else {
            confirmBtn.isHidden = true
        }
    }
}


 
