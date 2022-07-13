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
        $0.tintColor = .white
        $0.backgroundColor = .white
        $0.setImage(UIImage(named: "back_arrow"), for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    let navigationTitle = UILabel().then{
        $0.font = UIFont.nbFont(type: .header)
        $0.textColor = .black
    }
    
    init(frame: CGRect, _ navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        
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
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(36)
            make.bottom.equalToSuperview().offset(2)
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
