//
//  DiaryBannerInSummaryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class DiaryBannerInSummaryTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "diaryBannerCell"
    
    let backView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    let selectedBackView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    let writeDiaryBanner = UILabel().then{
        $0.text = "오늘의 일기를 작성해주세요!"
        $0.setTypoStyleWithSingleLine(typoStyle: .extrabold13)
    }
    
    let titleBackgroundView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .transparent
        self.selectedBackgroundView = selectedBackView
        
        //set view
        self.contentView.addSubview(backView)
        
        backView.addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(writeDiaryBanner)
        
        //set constraint
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(62)
            make.width.equalToSuperview()
        }
        
        backView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        titleBackgroundView.snp.makeConstraints{ make in
            make.height.equalTo(46)
            make.top.leading.trailing.equalToSuperview()
        }
        
        writeDiaryBanner.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(19)
            make.centerY.equalToSuperview()
            make.bottom.equalToSuperview().offset(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
