//
//  BaseTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell, BaseSourceProtocol {
    
    let baseView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
