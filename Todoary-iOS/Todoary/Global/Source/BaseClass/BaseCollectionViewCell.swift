//
//  BaseCollectionViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, CellReuseProtocol{
    
    let baseView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        hierarchy()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {}
    
    func hierarchy(){
        self.contentView.addSubview(baseView)
    }
    
    func layout(){
        baseView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
