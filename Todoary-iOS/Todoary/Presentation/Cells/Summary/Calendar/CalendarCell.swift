//
//  CalendarCell.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/17.
//

import UIKit

class CalendarCell : UICollectionViewCell {
    
    override var isSelected: Bool{
            didSet{
                if isSelected{
                    dateLabel.layer.backgroundColor = UIColor.white.cgColor
//                    UIColor.calendarSelectColor.cgColor
                    dateLabel.textColor = .white
                    
                    select.isHidden = false
                    
                }
                else{
                    dateLabel.textAlignment = .center
                    dateLabel.textColor = .black
                    let font: CGFloat = Const.Device.isSmallDevice ? 11.5 : 14
                    dateLabel.font = UIFont.nbFont(ofSize: font, weight: .bold)
                    dateLabel.layer.backgroundColor = UIColor.calendarExistColor.cgColor
                    let cornerRadius: CGFloat = Const.Device.isSmallDevice ? 9.87 : 12
                    dateLabel.layer.cornerRadius = cornerRadius
                    
                    select.isHidden = true
                }
            }
        }
    
    let dateLabel = UILabel().then{
        $0.text = "월"
        $0.textAlignment = .center
        $0.textColor = .black
        let font: CGFloat = Const.Device.isSmallDevice ? 11.5 : 14
        $0.font = UIFont.nbFont(ofSize: font, weight: .bold)
        $0.layer.backgroundColor = UIColor.calendarExistColor.cgColor
        let cornerRadius: CGFloat = Const.Device.isSmallDevice ? 9.87 : 12
        $0.layer.cornerRadius = cornerRadius
    }
    
    let diary = UIView().then{
        $0.isHidden = true
        $0.backgroundColor = UIColor(red: 49/255, green: 131/255, blue: 255/255, alpha: 1)
        let cornerRadius: CGFloat = Const.Device.isSmallDevice ? 5.76 : 7
        $0.layer.cornerRadius = cornerRadius/2
    }
    
    let select = UIImageView().then{
        $0.isHidden = true
        $0.image = UIImage(named: "today_character")
        $0.contentMode = .scaleToFill
        let cornerRadius: CGFloat = Const.Device.isSmallDevice ? 9.87 : 12
        $0.layer.cornerRadius = cornerRadius
        $0.clipsToBounds = true
        $0.layer.shadowRadius = 4.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setUpView()
        setConstraint()
    }
    
    private func setUpView(){
        addSubview(dateLabel)
        addSubview(diary)
        addSubview(select)
    }
    
    private func setConstraint() {
        let size: CGFloat = Const.Device.isSmallDevice ? 35 : 40
        let diarySize: CGFloat = Const.Device.isSmallDevice ? 5.76 : 7
        let selectSize: CGFloat = Const.Device.isSmallDevice ? 49 : 55
        dateLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        
        diary.snp.makeConstraints{ make in
            make.centerX.equalTo(dateLabel)
            make.bottom.equalTo(dateLabel.snp.bottom).offset(-4)
            make.width.equalTo(diarySize)
            make.height.equalTo(diarySize)
        }
        
        select.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(selectSize)
            make.height.equalTo(selectSize)
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
