//
//  TodoCategoryViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/23.
//

import UIKit

class TodoCalendarCell : UICollectionViewCell {
    
    override var isSelected: Bool{
            didSet{
                if isSelected{
                    dateLabel.layer.backgroundColor = UIColor.calendarSelectColor.cgColor
                    dateLabel.textColor = .white
                    dateLabel.layer.shadowRadius = 4.0
                    dateLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                    dateLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
                    dateLabel.layer.shadowOpacity = 1
                    dateLabel.layer.masksToBounds = false
                }
                else{
                    dateLabel.textAlignment = .center
                    dateLabel.textColor = .black
                    dateLabel.font = UIFont.nbFont(ofSize: 16, weight: .medium)
                    dateLabel.layer.backgroundColor = UIColor.calendarExistColor.cgColor
                    dateLabel.layer.cornerRadius = 12
                }
            }
        }
    
    let dateLabel = UILabel().then{
        $0.text = "10"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.nbFont(ofSize: 16, weight: .medium)
        $0.layer.backgroundColor = UIColor.calendarExistColor.cgColor
        $0.layer.cornerRadius = 12
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setUpView()
        setConstraint()
    }
    
    private func setUpView(){
        addSubview(dateLabel)
    }
    
    private func setConstraint() {
        dateLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(42)
            make.height.equalTo(42)
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

