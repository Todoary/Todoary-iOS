//
//  AskView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import Foundation

class AskView: BaseView{
    
    
    
    let tableView = UITableView().then{
        $0.isScrollEnabled = false
        
        $0.register(DefaultTableViewCell.self, forCellReuseIdentifier: "askSettingCell")
    }
    
    let emailHiddenButton = UIButton().then{
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    override func hierarchy(){
        self.addSubview(tableView)
    }
    
    override func layout(){
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(26)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
