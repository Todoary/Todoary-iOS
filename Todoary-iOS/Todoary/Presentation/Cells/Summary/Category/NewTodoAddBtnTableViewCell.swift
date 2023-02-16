//
//  NewTodoAddBtnTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/24.
//

import UIKit

class NewTodoAddBtnTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "addBtnCell"
    
    var delegate: MoveViewController?
    
    let backView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowRadius = 7.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    lazy var addBtn = UIButton().then{
        $0.backgroundColor = .transparent
        $0.addTarget(self, action: #selector(addBtnDidClicked), for: .touchUpInside)
    }
    
    let addImage = UIImageView().then{
        $0.image = Image.categoryPlus
    }
    
    let selectedView = UIView().then{
        $0.backgroundColor = .white
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(backView)
        self.selectedBackgroundView = selectedView
        
        backView.addSubview(addImage)
        backView.addSubview(addBtn)
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(47+20)
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        addBtn.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        addImage.snp.makeConstraints{ make in
            make.width.height.equalTo(25)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func addBtnDidClicked(){
        delegate?.moveToViewController()
    }
    
}

protocol MoveViewController{
    func moveToViewController()
}
