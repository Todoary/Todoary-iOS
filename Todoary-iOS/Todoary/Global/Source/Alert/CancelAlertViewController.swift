//
//  CancelAlertViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/20.
//

import UIKit

class CancelAlertViewController: BaseAlertViewController {
    
    lazy var cancelBtn = UIButton().then{
        $0.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        $0.setTitle("아니오", for: .normal)
        $0.layer.cornerRadius = 11
        $0.setTitleColor(UIColor(red: 20/255, green: 37/255, blue: 83/255, alpha: 1), for: .normal)
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: .semibold17)
        $0.titleEdgeInsets = UIEdgeInsets(top: 9, left: 0, bottom: 8, right: 0)
        $0.titleLabel?.textAlignment = .center
        $0.addTarget(self, action: #selector(cancelBtnDidClicked), for: .touchUpInside)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        confirmBtn.setTitle("네", for: .normal)
    }
    
    override func setUpView() {
        
        super.btnStackView.addArrangedSubview(cancelBtn)
        
        super.setUpView()
    }
    
    override func setUpConstraint() {
        
        super.setUpConstraint()
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(25)
        }
        
        btnStackView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(23)
        }
        
        cancelBtn.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(confirmBtn)
        }
        
        confirmBtn.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
        }
    }
    
    @objc func cancelBtnDidClicked(){
        self.dismiss(animated: false, completion: nil)
    }
}
