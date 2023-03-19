//
//  WeekCell.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/18.
//

import UIKit

class WeekCell : UICollectionViewCell {
    
    let weekLabel = UILabel().then{
        $0.text = "월"
        $0.textAlignment = .center
        $0.textColor = .black
        let font: CGFloat = Const.Device.isSmallDevice ? 11.5 : 14
        $0.font = UIFont.nbFont(ofSize: font, weight: .extraBold)
        $0.backgroundColor = .white
        $0.addLetterSpacing(spacing: 0.26)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setUpView()
        setConstraint()
    }
    
    private func setUpView(){
        addSubview(weekLabel)
    }
    
    private func setConstraint() {
        weekLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(42)
            make.height.equalTo(20)
        }
      }
    
    required init?(coder: NSCoder) {
        fatalError("do not use in storyboard")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}

