//
//  DiaryBannerInSummaryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class DiaryBannerInSummaryTableViewCell: BaseTableViewCell {
    
    private let bannerTitle = UILabel().then{
        $0.text = "오늘의 일기를 작성해주세요!"
        $0.setTypoStyleWithSingleLine(typoStyle: .extrabold13)
    }
    
    private let titleBackgroundView = ShadowView(cornerRadius: 20)

    override func style() {
        super.style()
        self.backgroundColor = .transparent
        self.selectedBackgroundView?.backgroundColor = .transparent
    }
    
    override func hierarchy() {
        super.hierarchy()
        baseView.addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(bannerTitle)
    }
    
    override func layout() {
        
        super.layout()
        
        baseView.snp.makeConstraints{
            $0.height.equalTo(62)
        }
        titleBackgroundView.snp.makeConstraints{
            $0.height.equalTo(46)
            $0.top.equalToSuperview().offset(3)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-30)
        }
        bannerTitle.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(19)
            $0.centerY.equalToSuperview()
            $0.bottom.equalToSuperview().offset(17)
        }
    }
}
