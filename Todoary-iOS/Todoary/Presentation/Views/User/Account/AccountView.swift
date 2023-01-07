//
//  AccountViewController+Layout.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/10.
//

import UIKit

class AccountView : BaseView {
    
    //tableView
    
    let tableView = UITableView().then{
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.register(AccountTableViewCell.self, forCellReuseIdentifier: "accountTableViewCell")
    }
    
    //profile
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "profile")
        $0.contentMode = .scaleAspectFill
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1).cgColor
        $0.layer.cornerRadius = 85/2
        $0.clipsToBounds = true
    }
    
    let nickName = UILabel().then{
        $0.text = ""
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.36)
        $0.font = UIFont.nbFont(type: .header)
    }
    
    let introduce = UILabel().then{
        $0.text = ""
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body1)
    }
    
    let profileChangeButton = UIButton().then{
        $0.titleEdgeInsets = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        $0.setTitle("프로필 변경", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.silver_115, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 13, weight: .semibold)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_115.cgColor
        $0.layer.cornerRadius = 31/2
    }
    
    let accountTitle = UILabel().then{
        $0.text = "계정"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    //account
    let userAccount = UILabel().then{
        $0.text = ""
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.32)
        $0.font = UIFont.nbFont(type: .tableCell)
    }
    
    let accountBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    override func hierarchy(){

        self.addSubview(profileImage)
        self.addSubview(nickName)
        self.addSubview(introduce)
        self.addSubview(profileChangeButton)
        
        self.addSubview(accountTitle)
        self.addSubview(userAccount)
        self.addSubview(accountBorderLine)
        
        self.addSubview(tableView)


    
    }
    
    override func layout(){

        //profile
        profileImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(39)
            make.leading.equalToSuperview().offset(42)
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
        nickName.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(51)
            make.leading.equalTo(profileImage.snp.trailing).offset(17)
        }
        
        introduce.snp.makeConstraints{ make in
            make.top.equalTo(nickName.snp.bottom).offset(10)
            make.leading.equalTo(nickName.snp.leading)
            make.trailing.equalToSuperview().offset(-31)
        }
        
        profileChangeButton.snp.makeConstraints{ make in
            make.top.equalTo(introduce.snp.bottom).offset(38)
            make.centerX.equalToSuperview()
            make.width.equalTo(118)
            make.height.equalTo(31)
        }
        
        //account
        accountTitle.snp.makeConstraints{ make in
            make.top.equalTo(profileChangeButton.snp.bottom).offset(41)
            make.leading.equalToSuperview().offset(31)
        }
        
        userAccount.snp.makeConstraints{ make in
            make.centerY.equalTo(accountTitle)
            make.trailing.equalToSuperview().offset(-31)
        }
        
        accountBorderLine.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(1)
            make.leading.equalTo(accountTitle.snp.leading)
            make.top.equalTo(accountTitle.snp.bottom).offset(17)
        }
        
        //tableView
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(accountBorderLine.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
