//
//  ToastMessageView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/08/11.
//

import UIKit

class ToastMessageView: UIView {
    
    let toastMessageLabel = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.nbFont(ofSize: 12, weight: .medium)
    }
    

    init(message: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1)
        self.layer.cornerRadius = 35/2
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        
        
        self.snp.makeConstraints{ make in
            make.height.equalTo(35)
        }
        
        self.addSubview(toastMessageLabel)
        
        toastMessageLabel.snp.makeConstraints{ make in
            make.centerY.centerX.equalToSuperview()
        }
        
        self.toastMessageLabel.text = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
