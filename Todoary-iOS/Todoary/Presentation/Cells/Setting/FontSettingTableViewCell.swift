//
//  FontSettingTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/11.
//

import UIKit

class FontSettingTableViewCell: UITableViewCell {
    
    let backView = UIView()
    
    let cellTitle = UILabel().then{
        $0.labelTypeSetting(type: .tableCell)
    }
    
    let radioButton = UIButton().then{
        $0.setImage(UIImage(named: "check_circle_blank"), for: .normal)
        $0.setImage(UIImage(named: "check_circle"), for: .selected)
    }
    
    let separatorLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let selectedBackView = UIView().then{
        $0.backgroundColor = .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpConstraint()
        
        self.selectedBackgroundView = selectedBackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        self.backView.addSubview(cellTitle)
        self.backView.addSubview(radioButton)
        self.backView.addSubview(separatorLine)
        
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
            make.leading.equalToSuperview().offset(31)
            make.centerY.equalToSuperview()
        }
        
        self.radioButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-31)
            make.centerY.equalToSuperview().offset(-1)
            make.width.height.equalTo(20)
        }
        
        self.separatorLine.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
        }
    }

}
