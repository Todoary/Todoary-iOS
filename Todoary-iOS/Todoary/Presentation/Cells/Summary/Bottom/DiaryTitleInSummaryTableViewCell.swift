//
//  DiaryInSummaryTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

import UIKit

class DiaryTitleInSummaryTableViewCell: BaseTableViewCell {
    
    var isDiaryExist: Bool = false{
        didSet{
            deleteBtn.isHidden = isDiaryExist ? false : true
        }
    }
    var delegate: SummaryCellDelegate?
    
    private let titleBackgroundView = ShadowView(cornerRadius: 24/2)
    private let diaryTitle = UILabel().then{
        $0.text = "DIARY"
        $0.textColor = .summaryTitle
        $0.setTypoStyleWithSingleLine(typoStyle: .extrabold12)
    }
    
    private lazy var deleteBtn = UIButton().then{
        $0.setImage(Image.summeryTrash, for: .normal)
    }
    
    override func style() {
        super.style()
        self.backgroundColor = .transparent
        self.selectedBackgroundView?.backgroundColor = .transparent
    }
    
    override func hierarchy() {
        super.hierarchy()
        baseView.addSubview(titleBackgroundView)
        baseView.addSubview(deleteBtn)
        
        titleBackgroundView.addSubview(diaryTitle)
    }
    
    override func layout() {
        
        super.layout()
        
        baseView.snp.makeConstraints{
            $0.height.equalTo(73.5)
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
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        deleteBtn.addTarget(self, action: #selector(willDeleteDiary), for: .touchUpInside)
    }
    
    @objc private func willDeleteDiary(){
        delegate?.willShowDiaryDeleteAlert()
    }
}
