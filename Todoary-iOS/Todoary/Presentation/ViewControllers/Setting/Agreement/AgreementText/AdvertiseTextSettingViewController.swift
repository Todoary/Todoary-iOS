//
//  AdvertiseTextSettingViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/08/12.
//

import Foundation
import UIKit
import SnapKit
import Then

class AdvertiseTextSettingViewController : BaseViewController {

    let mainView = AdvertiseTextSettingView()
    
    override func style(){
        super.style()
        navigationTitle.text = "광고성 정보 수신 동의"
    }
    
    override func layout() {
        
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        mainView.adCheckBtn.addTarget(self, action: #selector(requestPatchAdvertiseAgreement), for: .touchUpInside)
    }
    
    @objc func requestPatchAdvertiseAgreement() {
        
        mainView.adCheckBtn.isSelected.toggle()
        
        MarketingService.shared.modifyMarketingAgreementStatus(request: mainView.adCheckBtn.isSelected){ result in
            switch result{
            case .success:
                break
            default:
                self.mainView.adCheckBtn.isSelected.toggle()
                break
            }
        }
                                                
    }
}
