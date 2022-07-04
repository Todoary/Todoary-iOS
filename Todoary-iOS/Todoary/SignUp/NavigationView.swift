//
//  NavigationView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/03.
//

import UIKit

class NavigationView: UIView {

    let backBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_arrow"), for: .normal)
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
            make.height.equalTo(31)
        }
        
        backBtn.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(22)
            make.centerY.equalToSuperview()
            make.width.equalTo(9)
            make.height.equalTo(17)
        }
        
        navigationTitle.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn)
        }
    }
    
}
