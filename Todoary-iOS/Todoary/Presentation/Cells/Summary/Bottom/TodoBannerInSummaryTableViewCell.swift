//
//  TodoBannerInSummaryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/29.
//

import UIKit

class TodoBannerInSummaryTableViewCell: BaseTableViewCell {
    
    private let backgroundWhiteView = ShadowView(cornerRadius: 20)
    private lazy var checkBox = UIButton().then{
        $0.setImage(Image.todoCheckEmpty, for: .normal)
    }
    private let titleLabel = UILabel().then{
        $0.text = "오늘의 할 일은 무엇인가요?"
        $0.textColor = .black
        $0.setTypoStyleWithSingleLine(typoStyle: .bold15_18)
    }
    
    override func style() {
        super.style()
        self.selectedBackgroundView?.backgroundColor = .transparent
    }
    
    override func hierarchy() {
        super.hierarchy()
        baseView.addSubview(backgroundWhiteView)
        backgroundWhiteView.addSubview(checkBox)
        backgroundWhiteView.addSubview(titleLabel)
    }
    
    override func layout() {
        
        super.layout()
        
        baseView.snp.makeConstraints{
            $0.height.equalTo(75)
        }
        backgroundWhiteView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-15)
        }
        
        checkBox.snp.makeConstraints{
            $0.width.height.equalTo(24)
            $0.top.equalToSuperview().offset(18)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(19)
        }
        titleLabel.snp.makeConstraints{
            $0.leading.equalTo(checkBox.snp.trailing).offset(13)
            $0.centerY.equalTo(checkBox)
        }
    }
}
