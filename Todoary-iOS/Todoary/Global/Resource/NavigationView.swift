//
//  NavigationView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/03.
//

import UIKit

class NavigationView: UIView {
    
    let navigationController: UINavigationController!

    lazy var backBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_arrow"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    let navigationTitle = UILabel().then{
        $0.setTypoStyleWithSingleLine(typoStyle: .bold18)
        $0.textColor = .black
    }
    
    init(frame: CGRect, _ navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        
        super.init(frame: .zero)

        setUpView()
        setUpConstraint()
        
        self.backgroundColor = .white
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
            make.height.equalTo(95)
        }
        
        backBtn.snp.makeConstraints{ make in
            make.width.equalTo(61)
            make.height.equalTo(55)
            make.bottom.leading.equalToSuperview()
        }
        
        navigationTitle.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-3)
            make.height.equalTo(22)
        }
    }
    
    @objc
    func backButtonDidClicked(_ sender: UIButton){
        self.navigationController.popViewController(animated: true)
    }
    
}
