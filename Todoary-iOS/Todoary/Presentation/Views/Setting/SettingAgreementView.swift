//
//  SettingAgreementView.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit

class SettingAgreementView: BaseView{
    
    let tableView = UITableView().then{
        $0.register(SettingAgreementViewCell.self, forCellReuseIdentifier: "SettingAgreementViewCell")
    }
    
    override func hierarchy(){
        self.addSubview(tableView)
    }
    
    override func layout(){
        
        //tableView
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(26)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
