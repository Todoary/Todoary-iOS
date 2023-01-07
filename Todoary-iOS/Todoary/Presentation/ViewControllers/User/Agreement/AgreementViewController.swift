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

class AgreementViewController : UIViewController {
    
    var isconfirmBtnEnabled = false{
        didSet{
            self.confirmBtnEnabled()
        }
    }
    
    var appleUserInfo: AppleLoginInput?
//    var userIdentifier : String?
    
    //MARK: - UIComponenets
    
    
    //MARK: - navigationView
    
    var navigationView: NavigationView!

    //MARK: - 텍스트

    let agreeTitle = UILabel().then{
        $0.text = "Todoary 서비스 이용약관에 동의해 주세요."
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }
    
    let allCheckText = UILabel().then{
        $0.text = "전체동의"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .subtitle)
    }
    
    //MARK: - 약관 제목버튼(약관 내용페이지로 연결)
    
    let privacyTitle = UIButton().then{
        $0.setTitle("개인 정보 취급방침 동의 (필수)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.setUnderline()
        $0.addTarget(self, action: #selector(privacyTitleDIdTab), for: .touchUpInside)
    }
    
    let useServiceTitle = UIButton().then{
        $0.setTitle("서비스 이용약관 동의 (필수)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.setUnderline()
        $0.addTarget(self, action: #selector(useServiceTitleDIdTab), for: .touchUpInside)
    }
    
    let adTitle = UIButton().then{
        $0.setTitle("광고성 정보 수신 동의 (선택)", for: .normal)
        $0.setTitleColor(.headline, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
        $0.titleLabel?.textAlignment = .left
        $0.setUnderline()
        $0.addTarget(self, action: #selector(ADTitleDIdTab), for: .touchUpInside)
    }
    
//    let locationTitle = UIButton().then{
//        $0.setTitle("위치정보 이용 동의 (선택)", for: .normal)
//        $0.setTitleColor(.headline, for: .normal)
//        $0.titleLabel?.font = UIFont.nbFont(type: .body1)
//        $0.titleLabel?.textAlignment = .left
//        $0.setUnderline()
//    }


    //MARK: - 약관 체크버튼 (필수 동의를 해야만 확인버튼을 누를수 있음)
    
    let allCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.addTarget(self, action: #selector(allcheckBtndidcheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
    }
    
    let privacyCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.addTarget(self, action: #selector(privacydidCheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(allagreementdidcheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
    }
    
    let useServiceCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.addTarget(self, action: #selector(useServicedidCheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(allagreementdidcheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
    }
    
    let adCheckBtn = UIButton().then{
        $0.setImage(UIImage(named: "check_box"), for: .selected)
        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
        $0.addTarget(self, action: #selector(ADdidCheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(allagreementdidcheck), for: .touchUpInside)
        $0.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
    }
//
//    let locationCheckBtn = UIButton().then{
//        $0.setImage(UIImage(named: "check_box"), for: .selected)
//        $0.setImage(UIImage(named: "check_box_outline_blank"), for: .normal)
//        $0.addTarget(self, action: #selector(locationdidCheck), for: .touchUpInside)
//        $0.addTarget(self, action: #selector(allagreementdidcheck), for: .touchUpInside)
//        $0.addTarget(self, action: #selector(essentialCheckBtnDidTab), for: .touchUpInside)
//    }

    
    //MARK: - BorderLine
    
    let privacyBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    let useServiceBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let adBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let locationBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }

    let agreeAllBorderLine = UIView().then{
        $0.backgroundColor = .todoaryGrey
    }
    
    //MARK: -  확인 버튼(필수 동의를 마치면 활성화)
    
    let confirmBtn = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .buttonColor
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.cornerRadius = 52/2
        $0.addTarget(self, action: #selector(confirmBtnDidTab), for: .touchUpInside)
    }
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        navigationView = NavigationView(frame: .zero , self.navigationController!).then{
            $0.navigationTitle.text = "약관동의"
        }
        

        setUpView()
        setUpConstraint()
    }
  
    //MARK: - agreementTitleDIdTab
    
    @objc func privacyTitleDIdTab() {
        let PrivacyTextViewController = PrivacyTextViewController()
        navigationController?.pushViewController(PrivacyTextViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
       }
    
    @objc func useServiceTitleDIdTab() {
        let UseServiceViewController = UseServiceViewController()
        navigationController?.pushViewController(UseServiceViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
       }
    
    @objc func ADTitleDIdTab() {
        let AdTextViewController = AdTextViewController()
        navigationController?.pushViewController(AdTextViewController, animated: true)
        navigationController?.isNavigationBarHidden = true
       }
    
    
    
    
    //MARK: - eachCheckBtndidCheck
    
    @objc func privacydidCheck() {
        if privacyCheckBtn.isSelected{ privacyCheckBtn.isSelected = false
            } else {privacyCheckBtn.isSelected = true}
    }
    
    @objc func useServicedidCheck() {
        if useServiceCheckBtn.isSelected{ useServiceCheckBtn.isSelected = false
            } else {useServiceCheckBtn.isSelected = true}
    }
        
    @objc func ADdidCheck() {
        if adCheckBtn.isSelected{ adCheckBtn.isSelected = false
            } else {adCheckBtn.isSelected = true}
    }
        
//    @objc func locationdidCheck() {
//        if locationCheckBtn.isSelected{ locationCheckBtn.isSelected = false
//            } else {locationCheckBtn.isSelected = true}
//    }
//
    //MARK: - allCheckBtndidCheck
    
    @objc func allcheckBtndidcheck() {
        if allCheckBtn.isSelected {
            
            allCheckBtn.isSelected = false
            privacyCheckBtn.isSelected = false
            useServiceCheckBtn.isSelected = false
            adCheckBtn.isSelected = false
//            locationCheckBtn.isSelected = false
            
        } else {
            
            allCheckBtn.isSelected = true
            privacyCheckBtn.isSelected = true
            useServiceCheckBtn.isSelected = true
            adCheckBtn.isSelected = true
//            locationCheckBtn.isSelected = true
            }
        }
    
    @objc func allagreementdidcheck() {
        if  privacyCheckBtn.isSelected == true
            && useServiceCheckBtn.isSelected == true
                && adCheckBtn.isSelected == true {
//            && locationCheckBtn.isSelected == true
            
            allCheckBtn.isSelected = true
            
        } else {
            allCheckBtn.isSelected = false}
            
        }
        
        //MARK: - essentialagreementdidcheck
        
    @objc func confirmBtnEnabled() {
        if isconfirmBtnEnabled{
           confirmBtn.isEnabled = true
            }else{
                confirmBtn.isEnabled = false
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
            appleInfo.isTermsEnable = adCheckBtn.isSelected
            print(appleInfo)
            AppleLoginDataManager().post(self, parameter: appleInfo)
        }else{
            //일반 회원가입 로직
            let vc = SignUpViewController()
            vc.isMarketingAgree = adCheckBtn.isSelected
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            navigationController?.isNavigationBarHidden = true
        }
    }
    
    @objc func essentialCheckBtnDidTab() {
        if privacyCheckBtn.isSelected == false ||
           useServiceCheckBtn.isSelected == false
        {
           isconfirmBtnEnabled = false
        }else{
            isconfirmBtnEnabled = true
        }
    }
        
    @objc func backBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
        }
    }



