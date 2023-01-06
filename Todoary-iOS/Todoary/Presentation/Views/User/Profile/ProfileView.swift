//
//  ProfileViewController+Layout.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/11.
//

import UIKit

class ProfileView: BaseView {
    
    //profile
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "profile")
        $0.contentMode = .scaleAspectFill
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1).cgColor
        $0.layer.cornerRadius = 85/2
        $0.clipsToBounds = true
    }
    
    let imagePicker = UIButton().then{
        $0.titleEdgeInsets = UIEdgeInsets(top: 1.5, left: 0, bottom: 0, right: 0)
        $0.setTitle("사진 변경", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.silver_115, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 12, weight: .semibold)
        $0.layer.borderColor = UIColor.silver_115.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 26/2
    }
    
    let nickNameTitle = UILabel().then{
        $0.text = "닉네임"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let nickNameTf = UITextField().then{
        $0.font = UIFont.nbFont(type: .tableCell)
        $0.addLeftPadding()
        $0.addLetterSpacing(spacing: 0.28)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
    }
    
    let nickNameCount = UILabel().then{
        $0.text = "0/10"
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(ofSize: 12, weight: .medium)
    }
    
    let nickNameNotice = UILabel().then{
        $0.isHidden = true
        $0.text = "이미 사용중인 닉네임입니다."
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(ofSize: 12, weight: .medium)
    }
    
    let introduceTitle = UILabel().then{
        $0.text = "한줄소개"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let introduceTf = UITextView().then{
        $0.text = "소개글을 입력해주세요"
        $0.font = UIFont.nbFont(type: .tableCell)
        $0.addLeftPadding()
        $0.textViewTypeSetting()
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
    }
    
    let introduceCount = UILabel().then{
        $0.text = "0/30"
        $0.textColor = .todoaryGrey
        $0.font = UIFont.nbFont(ofSize: 12, weight: .medium)
    }
    
    let confirmBtn = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
    }
    
    override func hierarchy(){
        
        self.addSubview(profileImage)
        self.addSubview(imagePicker)
        self.addSubview(nickNameTitle)
        self.addSubview(nickNameTf)
        self.addSubview(nickNameCount)
        self.addSubview(nickNameNotice)
        self.addSubview(introduceTitle)
        self.addSubview(introduceTf)
        self.addSubview(introduceCount)
        self.addSubview(confirmBtn)
        


    
    }
    
    override func layout(){
        

        //profile
        profileImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(85)
            make.height.equalTo(85)
        }
        
        imagePicker.snp.makeConstraints{ make in
            make.top.equalTo(profileImage.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.equalTo(82)
            make.height.equalTo(26)
        }
        
        nickNameTitle.snp.makeConstraints{ make in
            make.top.equalTo(imagePicker.snp.bottom).offset(31)
            make.leading.equalToSuperview().offset(31)
        }
        
        nickNameTf.snp.makeConstraints{ make in
            make.top.equalTo(nickNameTitle.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(45)
        }
        
        nickNameCount.snp.makeConstraints{ make in
            make.centerY.equalTo(nickNameTitle)
            make.leading.equalTo(nickNameTitle.snp.trailing).offset(8)
            make.width.equalTo(40)
        }
        
        nickNameNotice.snp.makeConstraints{ make in
            make.centerY.equalTo(nickNameTitle)
            make.trailing.equalToSuperview().offset(-50)
            make.width.equalTo(234)
        }
        
        introduceTitle.snp.makeConstraints{ make in
            make.top.equalTo(nickNameTf.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(31)
        }
        
        introduceTf.snp.makeConstraints{ make in
            make.top.equalTo(introduceTitle.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(67)
        }
        
        introduceCount.snp.makeConstraints{ make in
            make.centerY.equalTo(introduceTitle)
            make.leading.equalTo(introduceTitle.snp.trailing).offset(8)
            make.width.equalTo(40)
        }
        
        //button
        confirmBtn.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-47)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-26)
            make.height.equalTo(52)
        }
        
        
    }
}

