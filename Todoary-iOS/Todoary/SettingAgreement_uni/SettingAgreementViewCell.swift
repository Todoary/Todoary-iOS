//
//  SettingAgreementViewCell.swift
//  Todoary
//
//  Created by 예리 on 2022/07/11.
//

import Foundation
import UIKit

class SettingAgreementViewCell: UITableViewCell {
    
    let backView = UIView()
    
    let cellTitle = UILabel().then{
        $0.labelTypeSetting(type: .tableCell)
    }
    
    let title = UILabel().then{
        $0.text = "개인 정보 취급방침"
        $0.textColor = .black
        $0.font = UIFont.nbFont(type: .tableCell)
    }
    
    let arrowImage = UIImageView().then{
        $0.image = UIImage(named: "next_btn")
    }
    
    let separatorLine = UIView().then{
        $0.backgroundColor = .silver_225
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        backView.addSubview(cellTitle)
        backView.addSubview(arrowImage)
        backView.addSubview(separatorLine)
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        self.cellTitle.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(31)
        }
        
        self.arrowImage.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-31)
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.centerY.equalToSuperview().offset(-1)
        }
        
        self.separatorLine.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
        }
        
    }
    
}