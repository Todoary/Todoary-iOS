//
//  PrivacyTextViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/04.
//

import Foundation
import SnapKit

extension UIView {

}

extension PrivacyTextViewController {
    
    func setUpView(){
        
        
        self.view.addSubview(contentView)
        
        self.view.addSubview(navigationView)
        
        self.view.addSubview(contentScrollView)
        self.view.addSubview(privacyText)
        
    }
        
    
    func setUpConstraint(){

        
    //약관내용
        
        
        contentView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentScrollView.snp.makeConstraints{ make in
            make.top.equalTo(navigationView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(36)
            make.bottom.equalToSuperview().offset(-79)
            make.centerX.equalToSuperview()
        }
        
        contentScrollView.addSubview(privacyText)
    
        privacyText.snp.makeConstraints { (make) in
            make.top.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView)
            make.centerX.equalTo(contentScrollView)
            make.bottom.equalTo(contentScrollView)
        }
    }
}
