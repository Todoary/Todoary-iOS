//
//  NoTodoTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/04.
//

import UIKit

class NoTodoTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "noTodoCell"
    
    lazy var checkBox = UIButton().then{
        $0.setImage(UIImage(named: "todo_check_empty"), for: .normal)
    }
    
    let titleLabel = UILabel().then{
        $0.text  = "오늘의 할일은 무엇인가요?"
        $0.numberOfLines = 1
        $0.font = UIFont.nbFont(ofSize: 15, weight: .bold)
        $0.addLetterSpacing(spacing: 0.3)
        $0.setTextWithLineHeight(lineHeight: 22)
        $0.textColor = .black
    }
    
    let backView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowRadius = 7.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }

    let selectedView = UIView().then{
        $0.backgroundColor = .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectedBackgroundView = selectedView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        self.contentView.addSubview(backView)
        
        backView.addSubview(checkBox)
        backView.addSubview(titleLabel)
        
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(88)
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }

        checkBox.snp.makeConstraints{ make in
            make.width.height.equalTo(22)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(19)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(35)
            make.bottom.equalToSuperview().offset(-33)
            make.leading.equalTo(checkBox.snp.trailing).offset(9)
        }
        
    }
    
}
