//
//  AskViewController+Layout.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import Foundation

extension AskViewController{
    
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
