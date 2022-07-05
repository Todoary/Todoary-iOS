//
//  TestViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/05.
//

import UIKit

class TestViewController: UIViewController {
    
    var navigationView : NavigationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        navigationView = NavigationView(frame: .zero, self.navigationController!).then{
            $0.navigationTitle.text = "second"
        }
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(navigationView)
        self.navigationView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

}
