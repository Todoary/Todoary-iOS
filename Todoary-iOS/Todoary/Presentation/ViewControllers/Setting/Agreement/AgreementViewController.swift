//
//  AgreementViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/02.
//

import Foundation
import UIKit
import SnapKit
import Then

class AgreementViewController : BaseViewController {
    
    var isconfirmBtnEnabled = false{
        didSet{
            self.confirmBtnEnabled()
        }
    }
    
    var appleUserInfo: AppleSignUpRequestModel?
    
    let mainView = AgreementView()
    
    //MARK: - Override
    
    override func style() {
        super.style()
        navigationTitle.text = "약관동의"
    }
    
    override func layout() {
        
        super.layout()
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.bottom.equalToSuperview()
        }
    }
    
    override func initialize(){
        
        mainView.privacyField.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(privacyTitleDIdTab)))
        mainView.userServiceField.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(useServiceTitleDIdTab)))
        mainView.advertiseField.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ADTitleDIdTab)))
        
        
        mainView.allCheckBtn.addTarget(self, action: #selector(allcheckBtndidcheck), for: .touchUpInside)
        mainView.allCheckBtn.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
        
        mainView.privacyField.checkBox.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
        mainView.privacyField.checkBox.addTarget(self, action: #selector(privacydidCheck), for: .touchUpInside)
        mainView.privacyField.checkBox.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
        mainView.privacyField.checkBox.addTarget(self, action: #selector(allagreementdidcheck), for: .touchUpInside)
        mainView.privacyField.checkBox.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
        
        mainView.userServiceField.checkBox.addTarget(self, action: #selector(useServicedidCheck), for: .touchUpInside)
        mainView.userServiceField.checkBox.addTarget(self, action: #selector(allagreementdidcheck), for: .touchUpInside)
        mainView.userServiceField.checkBox.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
        
        mainView.advertiseField.checkBox.addTarget(self, action: #selector(ADdidCheck), for: .touchUpInside)
        mainView.advertiseField.checkBox.addTarget(self, action: #selector(allagreementdidcheck), for: .touchUpInside)
        mainView.advertiseField.checkBox.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
        
        mainView.confirmBtn.addTarget(self, action: #selector(confirmBtnDidTab), for: .touchUpInside)
    }
    
    
    //MARK: - agreementTitleDIdTab
    
    @objc func privacyTitleDIdTab() {
        let PrivacyTextViewController = PrivacyTextViewController()
        navigationController?.pushViewController(PrivacyTextViewController, animated: true)
    }
    
    @objc func useServiceTitleDIdTab() {
        let UseServiceViewController = UseServiceViewController()
        navigationController?.pushViewController(UseServiceViewController, animated: true)
    }
    
    @objc func ADTitleDIdTab() {
        let AdTextViewController = AdvertiseTextViewController()
        navigationController?.pushViewController(AdTextViewController, animated: true)
    }
    
    
    
    
    //MARK: - eachCheckBtndidCheck
    
    @objc func privacydidCheck() {
        mainView.privacyField.isSelected.toggle()
    }
    
    @objc func useServicedidCheck() {
        mainView.userServiceField.isSelected.toggle()
    }
    
    @objc func ADdidCheck() {
        mainView.advertiseField.isSelected.toggle()
    }
    
    //MARK: - allCheckBtndidCheck
    
    @objc func allcheckBtndidcheck() {
        if mainView.allCheckBtn.isSelected {
            mainView.allCheckBtn.isSelected = false
            mainView.privacyField.isSelected = false
            mainView.userServiceField.isSelected = false
            mainView.advertiseField.isSelected = false
        } else {
            mainView.allCheckBtn.isSelected = true
            mainView.privacyField.isSelected = true
            mainView.userServiceField.isSelected = true
            mainView.advertiseField.isSelected = true
        }
    }
    
    @objc func allagreementdidcheck() {
        if  mainView.privacyField.isSelected == true
                && mainView.userServiceField.isSelected == true
                && mainView.advertiseField.isSelected == true {
            mainView.allCheckBtn.isSelected = true
        } else {
            mainView.allCheckBtn.isSelected = false}
    }
    
    //MARK: - essentialagreementdidcheck
    
    @objc func confirmBtnEnabled() {
        if isconfirmBtnEnabled{
            mainView.confirmBtn.isEnabled = true
        }else{
            mainView.confirmBtn.isEnabled = false
        }
    }
    
    //TODO: -
    /*
     appleUserInfo nil일 경우 -> pop root로
     아닌 경우 -> signup
     */
    @objc func confirmBtnDidTab() {
        
        if var appleInfo = appleUserInfo{
            //애플 소셜 회원가입 로직
            appleInfo.isTermsEnable = mainView.advertiseField.isSelected
            requestAppleSignUp(parameter: appleInfo)
        }else{
            //일반 회원가입 로직
            let vc = SignUpViewController()
            vc.isMarketingAgree = mainView.advertiseField.isSelected
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @objc func essentialCheckBtnDidTab() {
        
        if mainView.privacyField.isSelected == false ||
            mainView.userServiceField.isSelected == false
        {
            isconfirmBtnEnabled = false
        }else{
            isconfirmBtnEnabled = true
        }
         
    }
    
    private func requestAppleSignUp(parameter: AppleSignUpRequestModel){
        
        AccountService.shared.generateAppleAccount(request: parameter){ result in
            switch result{
            case .success(let data):
                guard let data = data as? AppleSignUpResultModel else { return }
                KeyChain.create(key: Const.UserDefaults.appleIdentifier, value: parameter.userIdentifier)
                KeyChain.create(key: Const.UserDefaults.appleRefreshToken, value: data.appleRefreshToken)

                UserDefaults.standard.set(data.token.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(data.token.refreshToken, forKey: "refreshToken")

                self.navigationController?.pushViewController(HomeViewController(), animated: true)
                break
            default:
                DataBaseErrorAlert.show(in: self)
                break
            }
            
        }
    }
    
}



