//
//  DiaryInSummaryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class DiaryInSummaryTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "diaryTitleCell"
    
    let backView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    let selectedBackView = UIView().then{
        $0.backgroundColor = .transparent
    }
    
    let diaryTitle = UILabel().then{
        $0.text = "DIARY"
        $0.font = UIFont.nbFont(ofSize: 12, weight: .extraBold)
        $0.textColor = .summaryTitle
        $0.addLetterSpacing(spacing: 0.24)
    }
    
    let titleBackgroundView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24/2
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    lazy var deleteBtn = UIButton().then{
        $0.setImage(UIImage(named: "summery_trash"), for: .normal)
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .transparent
        self.selectedBackgroundView = selectedBackView
        
        //set view
        self.contentView.addSubview(backView)
        
        backView.addSubview(titleBackgroundView)
        backView.addSubview(deleteBtn)
        
        titleBackgroundView.addSubview(diaryTitle)
        
        //set constraint
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(73.5) //60.5
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        titleBackgroundView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(35)
            make.bottom.equalToSuperview().offset(-13)
            make.width.equalTo(60)
            make.height.equalTo(24)
        }
        
        diaryTitle.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        deleteBtn.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-27)
            make.width.equalTo(54)
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
