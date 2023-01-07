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
    
    //MARK: - UI
    
    let messageLabel = UILabel().then{
        $0.font = UIFont.nbFont(ofSize: 12, weight: .regular, type: .apple)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.labelAttributeSetting(letterSpacing: -0.08, lineHeight: 16)
    }
    
    //MARK: - Propertie

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUpView() {
        super.setUpView()
        
        self.containerView.addSubview(messageLabel)
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
