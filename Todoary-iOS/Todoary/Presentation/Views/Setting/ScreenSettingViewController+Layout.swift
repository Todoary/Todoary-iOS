//
//  ScreenSettingViewController+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import UIKit

extension ScreenSettingViewController {

    func setUpView(){
        self.view.addSubview(navigationView)
        self.view.addSubview(tableView)
    }
    
    func setUpConstraint(){
        
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(122)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
