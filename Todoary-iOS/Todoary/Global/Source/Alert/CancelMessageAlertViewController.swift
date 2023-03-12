//
//  CancelMessageAlertViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/20.
//

import UIKit

class CancelMessageAlertViewController: CancelAlertViewController {
    
    init(title: String, message: String){
        self.messageLabel.text = message
        super.init(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    let messageLabel = UILabel().then{
        $0.setTypoStyleWithMultiLine(typoStyle: .regualar12)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    //MARK: - Propertie
    
    override func setUpView() {
        super.setUpView()
        containerView.addSubview(messageLabel)
    }
    
    override func setUpConstraint() {
        
        super.setUpConstraint()
        
        titleLabel.snp.updateConstraints{
            $0.top.equalToSuperview().offset(20)
        }
        
        messageLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        btnStackView.snp.remakeConstraints{
            $0.top.equalTo(messageLabel.snp.bottom).offset(17)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().offset(-17)
        }
    }
}

class CancelReverseMessageAlertViewController: CancelMessageAlertViewController{
    override func cancelBtnDidClicked(){
        alertHandler?()
        self.dismiss(animated: false)
    }
    
    override func confirmBtnDidClicked() {
        self.dismiss(animated: false)
    }
}
