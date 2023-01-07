//
//  BaseCollectionViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, BaseSourceProtocol {
    
    let baseView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseViewConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func baseViewConfigure() {
        
        self.contentView.addSubview(baseView)
        
        baseView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
