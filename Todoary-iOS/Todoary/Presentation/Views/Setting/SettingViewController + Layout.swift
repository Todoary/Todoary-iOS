//
//  SettingViewController + Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit

extension  SettingViewController{
    
    func setUpView(){
        self.view.addSubview(tableView)
        
        self.view.addSubview(versionBorderLine1)
        self.view.addSubview(versionText)
        self.view.addSubview(versionNum)
        self.view.addSubview(versionBorderLine2)
    }
    
    func setUpConstraint(){
        
        //tableView
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(122)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(versionBorderLine1.snp.top)
        }
        
        //version
        
        versionBorderLine1.snp.makeConstraints{make in
            make.height.equalTo(1)
            make .width.equalTo(328)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(versionBorderLine2.snp.top).offset(-50)
        }
        
        versionText.snp.makeConstraints{make in
            make.width.equalTo(29)
            make.height.equalTo(19)
            make.leading.equalTo(versionBorderLine1)
            make.top.equalTo(versionBorderLine1.snp.bottom).offset(16)
        }
        
        versionNum.snp.makeConstraints{make in
            make.width.equalTo(21)
            make.height.equalTo(19)
            make.trailing.equalTo(versionBorderLine1)
            make.top.equalTo(versionBorderLine1.snp.bottom).offset(16)
        }
        
        versionBorderLine2.snp.makeConstraints{make in
            make.height.equalTo(1)
            make .width.equalTo(328)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-70)
        }
        
        
    }
}
