//
//  NavigationView.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/04.
//

import UIKit

class NavigationView: UIView {

    let backBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_arrow"), for: .normal)
        $0.addTarget(self, action: #selector(backBtnDidTab), for: .touchUpInside)
    }
    
    let navigationTitle = UILabel().then{
        $0.font = UIFont.nbFont(type: .header)
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        self.addSubview(backBtn)
        self.addSubview(navigationTitle)
    }
    
    func setUpConstraint(){
        
        self.snp.makeConstraints{ make in
            make.height.equalTo(84)
        }
        
        backBtn.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(22)
            make.width.equalTo(9)
            make.height.equalTo(17)
            make.bottom.equalToSuperview().offset(-7)
        }
        
        navigationTitle.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-3)
            make.height.equalTo(22)
        }
    }
    @objc func backBtnDidTab() {
        self.inputAccessoryViewController?.navigationController?.popViewController(animated: true)
        }

}
