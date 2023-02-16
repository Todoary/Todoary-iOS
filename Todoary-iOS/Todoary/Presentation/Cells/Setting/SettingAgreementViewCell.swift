//
//  SettingAgreementViewCell.swift
//  Todoary
//
//  Created by 예리 on 2022/07/11.
//

import Foundation
import UIKit

class SettingAgreementViewCell: UITableViewCell {
    static let identifier = "SettingAgreementViewCell"
    
    let main = UIView().then{
        $0.backgroundColor = .white
    }
    
    let title = UILabel().then{
        $0.text = "개인 정보 취급방침"
        $0.textColor = .black
        $0.setTypoStyleWithSingleLine(typoStyle: .medium16)
    }
    
    let nextBtn = UIButton().then{
        $0.setImage(Image.nextBtn, for: .normal)
    }
    
    let borderLine = UIView().then{
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
    
    private func setUpView(){
        self.contentView.addSubview(main)
        self.main.addSubview(title)
        self.main.addSubview(nextBtn)
        self.main.addSubview(borderLine)
    }
    
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.main.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        self.title.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(31)
        }
        
        self.nextBtn.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-31)
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.centerY.equalToSuperview().offset(-1)
        }
        
        self.borderLine.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
        }
        
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
              contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
}
