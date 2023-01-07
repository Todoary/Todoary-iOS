//
//  ConfirmAlertViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/20.
//

import UIKit

class ConfirmAlertViewController: BaseAlertViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        confirmBtn.setTitle("확인", for: .normal)
    }
    
    override func setUpConstraint() {
        
        super.setUpConstraint()
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(25)
        }
        
        btnStackView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(23)
        }
        
        confirmBtn.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
