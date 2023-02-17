//
//  DiaryTitleInSummaryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class DiaryInSummaryTableViewCell: BaseTableViewCell {
    
    private let backgroundWhiteView = ShadowView(cornerRadius: 20)
    private let diaryTitle = UILabel().then{
        $0.textColor = .black
        $0.numberOfLines = 1
        $0.setTypoStyleWithSingleLine(typoStyle: .extrabold13)
    }
    private let diaryTextView = UILabel().then{
        $0.numberOfLines = 0
    }
    
    override func style() {
        super.style()
        self.backgroundColor = .transparent
        self.selectedBackgroundView?.backgroundColor = .transparent
    }
    
    override func hierarchy() {
        super.hierarchy()
        baseView.addSubview(backgroundWhiteView)
        backgroundWhiteView.addSubview(diaryTitle)
        backgroundWhiteView.addSubview(diaryTextView)
    }
    
    override func layout() {
        
        super.layout()
        
        backgroundWhiteView.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(3)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(diaryTextView.snp.height).offset(63)
        }
        diaryTitle.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(23)
        }
        diaryTextView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(diaryTitle.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().offset(-23)
        }
    }
    
    func bindingDiaryData(_ diary: DiaryResultModel){
        self.diaryTitle.text = diary.title
        self.diaryTextView.attributedText = diary.content12AttributedString ?? NSAttributedString(string: "")
        self.diaryTextView.labelAttributeSetting(letterSpacing: 0.24, lineHeight: 14.4)
    }
}
