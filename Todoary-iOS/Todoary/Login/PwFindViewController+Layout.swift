//
//  PwFindViewController+Layout.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/02.
//
import UIKit

extension PwFindViewController {

    
    func setUpView(){
        
        self.view.addSubview(contentView)
        
        self.view.addSubview(navigationView)

        self.view.addSubview(idTitle)
        self.view.addSubview(idTf)
        self.view.addSubview(idBorderLine)
        
        self.view.addSubview(idNoticeLb)

        self.view.addSubview(idCertificationBtn)

        self.view.addSubview(certificationTitle)
        self.view.addSubview(certificationTf)
        self.view.addSubview(certificationBorderLine)
        self.view.addSubview(certificationOkBtn)
        
        self.view.addSubview(pwTitle)
        self.view.addSubview(pwTf)
        self.view.addSubview(pwBorderLine)
        self.view.addSubview(pwNoticeLb)
        
        self.view.addSubview(pwCertificationTf)
        self.view.addSubview(pwCertificationBorderLine)
        self.view.addSubview(pwCertificationNoticeLb)
        
        self.view.addSubview(confirmBtn)
    
    }
    
    func setUpConstraint(){
        
        contentView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        //navigation bar
        navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }

        //id
        idTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(156)
            make.leading.equalToSuperview().offset(38)
        }

        idTf.snp.makeConstraints{ make in
            make.top.equalTo(idTitle.snp.bottom).offset(16)
            make.width.equalTo(152)
            make.height.equalTo(20)
            make.leading.equalTo(idTitle)
        }
        
        idBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(314)
            make.height.equalTo(1)
            make.leading.equalTo(idTf.snp.leading)
            make.bottom.equalTo(idTf.snp.bottom).offset(3)
        }
        
        idNoticeLb.snp.makeConstraints{ make in
            make.top.equalTo(idBorderLine).offset(9)
            make.leading.equalToSuperview().offset(38)
        }
        
        idCertificationBtn.snp.makeConstraints{ make in
            make.width.equalTo(65)
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-40)
            make.centerY.equalTo(idTitle).offset(-2)
        }
        
        //certification
        certificationTitle.snp.makeConstraints{ make in
            make.top.equalTo(idBorderLine.snp.bottom).offset(46)
            make.leading.equalTo(idTitle)
        }

        certificationTf.snp.makeConstraints{ make in
            make.top.equalTo(certificationTitle.snp.bottom).offset(16)
            make.height.equalTo(20)
            make.leading.equalTo(idTitle)
            make.width.equalTo(261)
        }
        
        certificationBorderLine.snp.makeConstraints{ make in
            make.height.equalTo(1)
            make.leading.equalTo(idTf.snp.leading)
            make.trailing.equalToSuperview().offset(-38)
            make.bottom.equalTo(certificationTf.snp.bottom).offset(3)
        }
        
        certificationOkBtn.snp.makeConstraints{ make in
            make.width.equalTo(65)
            make.height.equalTo(22)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(idBorderLine.snp.bottom).offset(45)
        }
        
        //password
        pwTitle.snp.makeConstraints{ make in
            make.top.equalTo(certificationBorderLine).offset(55)
            make.leading.equalTo(idTitle)
        }
        
        pwTf.snp.makeConstraints{ make in
            make.top.equalTo(pwTitle.snp.bottom).offset(17)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.width.equalTo(261)
        }
        
        pwBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(certificationBorderLine)
            make.height.equalTo(1)
            make.leading.equalTo(idTf.snp.leading)
            make.bottom.equalTo(pwTf.snp.bottom).offset(3)
        }
        
        pwNoticeLb.snp.makeConstraints{ make in
            make.top.equalTo(pwBorderLine).offset(7)
            make.leading.equalToSuperview().offset(38)
        }
        
        pwCertificationTf.snp.makeConstraints{ make in
            make.top.equalTo(pwBorderLine.snp.bottom).offset(41)
            make.leading.equalTo(idTitle)
            make.height.equalTo(20)
            make.width.equalTo(261)
        }
        
        pwCertificationBorderLine.snp.makeConstraints{ make in
            make.width.equalTo(certificationBorderLine)
            make.height.equalTo(1)
            make.leading.equalTo(idTf.snp.leading)
            make.bottom.equalTo(pwCertificationTf.snp.bottom).offset(3)
        }
        
        pwCertificationNoticeLb.snp.makeConstraints{ make in
            make.top.equalTo(pwCertificationBorderLine).offset(7)
            make.leading.equalToSuperview().offset(38)
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
