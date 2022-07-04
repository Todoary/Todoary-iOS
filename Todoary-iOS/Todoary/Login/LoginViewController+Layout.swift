//
//  LoginViewController+Layout.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/01.
//

import UIKit

extension LoginViewController {
    
    func setUpView(){
        
        self.view.addSubview(idTitle)
        self.view.addSubview(idTf)
        self.view.addSubview(idBorderLine)
        
        self.view.addSubview(pwTitle)
        self.view.addSubview(pwTf)
        self.view.addSubview(pwBorderLine)
        
        self.view.addSubview(autoLoginBtn)
        self.view.addSubview(autoLoginTitle)
        
        self.view.addSubview(loginBtn)
        self.view.addSubview(appleBtn)
        self.view.addSubview(signUpBtn)
        
        self.view.addSubview(pwSearchBtn)
    
    }
    
    func setUpConstraint(){

        //id
        idTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(368)
            make.leading.equalToSuperview().offset(37)
        }

        idTf.snp.makeConstraints{ make in
            make.top.equalTo(idTitle.snp.bottom).offset(16)
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.leading.equalTo(idTitle)
        }
        
        idBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(314)
            make.height.equalTo(1)
            make.leading.equalTo(idTf.snp.leading)
            make.bottom.equalTo(idTf.snp.bottom).offset(3)
        }
     
        
        //password
        pwTitle.snp.makeConstraints{ make in
            make.top.equalTo(idBorderLine).offset(31)
            make.leading.equalTo(idTitle)
        }
        
        pwTf.snp.makeConstraints{ make in
            make.top.equalTo(pwTitle.snp.bottom).offset(16)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.width.equalTo(196)
        }
        
        pwBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(idBorderLine)
            make.height.equalTo(1)
            make.leading.equalTo(idTf.snp.leading)
            make.bottom.equalTo(pwTf.snp.bottom).offset(3)
        }
        
        //autologin
        
        autoLoginBtn.snp.makeConstraints{ make in
            make.trailing.equalTo(pwBorderLine)
            make.width.equalTo(22)
            make.height.equalTo(22)
            make.centerY.equalTo(autoLoginTitle).offset(-1)
            
        }
        
        autoLoginTitle.snp.makeConstraints{ make in
            make.top.equalTo(pwBorderLine).offset(10)
            make.trailing.equalTo(autoLoginBtn.snp.leading).offset(-3)
        }
        
        
        //button
        loginBtn.snp.makeConstraints{ make in
            make.top.equalTo(pwBorderLine).offset(65)
            make.centerX.equalToSuperview()
            make.width.equalTo(324)
            make.height.equalTo(51)
        }
        
        appleBtn.snp.makeConstraints{ make in
            make.top.equalTo(loginBtn.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.width.equalTo(324)
            make.height.equalTo(51)
        }
        
        signUpBtn.snp.makeConstraints{ make in
            make.top.equalTo(appleBtn.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.width.equalTo(324)
            make.height.equalTo(51)
        }
        
        pwSearchBtn.snp.makeConstraints{ make in
//            make.top.equalTo(signUpBtn.snp.bottom).offset(24)
            make.bottom.equalToSuperview().offset(-33.67)
            make.centerX.equalToSuperview()
            make.width.equalTo(171)
            make.height.equalTo(25)
        }
    }
}

