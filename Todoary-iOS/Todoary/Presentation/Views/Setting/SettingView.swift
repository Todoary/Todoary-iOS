//
//  SettingView.swift
//  Todoary
//
//  Created by 예리 on 2022/07/10.
//

import Foundation
import UIKit

class SettingView: UIView, BaseViewProtocol{
    
    //tableView
    let tableView = UITableView().then{
        $0.separatorStyle = .none
        $0.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
        $0.isScrollEnabled = false
        $0.backgroundColor = .white
        
//        $0.delegate = self
//        $0.dataSource = self
    }
    
    //version
    let versionBorderLine1 = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let versionText = UILabel().then{
        $0.text = "버전"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .tableCell)
    }
    
    let versionNum = UILabel().then{
        $0.text = "1.0"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .tableCell)
    }
    
    let versionBorderLine2 = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hierarchy() {
        self.addSubview(tableView)
        
        self.addSubview(versionBorderLine1)
        self.addSubview(versionText)
        self.addSubview(versionNum)
        self.addSubview(versionBorderLine2)
    }
    
    func layout() {
        
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(122)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(versionBorderLine1.snp.top)
        }

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
