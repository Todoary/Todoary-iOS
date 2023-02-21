//
//  GuideView.swift
//  Todoary
//
//  Created by 송채영 on 2023/02/21.
//

class GuideView: BaseView{
    
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
    
    override func hierarchy(){
        
        self.addSubview(onboardingImgScrollView)
        self.addSubview(onboardingPagecontrol)
    }
    
    
    override func layout(){
        let screenSize = UIScreen.main.bounds
        
        onboardingImgScrollView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(7)
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
    }
}

        
