//
//  PrivacyTextViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import UIKit
import SnapKit
import Then


class PrivacyTextViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    //navigationView
    let PrivacyNavigationView = NavigationView().then {
        $0.navigationTitle.text = "개인정보 취급방침"
    }
    
    
    //약관내용

    let contentScrollView = UIScrollView().then{
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
        $0.isScrollEnabled = true
        $0.indicatorStyle = .black
    }
    
    let privacyText = UILabel().then{
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body1)
        $0.setTextWithLineHeight(
            text: "개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침개인정보취급방침",
            lineHeight: 21)
    
    }

    override func viewDidLoad() {
    
        super.viewDidLoad()

        setUpView()
        setUpConstraint()
    }

}
