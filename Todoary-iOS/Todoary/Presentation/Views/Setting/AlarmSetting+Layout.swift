//
//  AlarmSettingViewController+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/10.
//

import UIKit

extension AlarmSettingViewController {

    func setUpView(){
        self.view.addSubview(tableView)
    }
    
    func setUpConstraint(){
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(122)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
