//
//  ColorPickerViewController + layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/24.
//

import Foundation

class ColorPickerView: BaseView {
    
    //MARK: - UIComponenets
    
    let categoryTitle = UITextField().then{
        $0.placeholder = "카테고리 이름을 입력해주세요"
        $0.font = UIFont.nbFont(ofSize: 15, weight: .medium)
        $0.addLeftPadding(padding: 11)
        $0.borderStyle = .none
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.cornerRadius = 10
        $0.setPlaceholderColor(.todoaryGrey)
    }
    
    let colorview = UIView().then{
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
    }
    
    

    
    override func hierarchy(){
        self.addSubview(categoryTitle)
        self.addSubview(colorview)
    }
    
    
    override func layout(){
        
        
        categoryTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(327)
            make.height.equalTo(45)

        }
        
        colorview.snp.makeConstraints{ make in
            make.top.equalTo(categoryTitle.snp.bottom).offset(18)
            make.width.equalTo(326)
            make.height.equalTo(196)
            make.centerX.equalToSuperview()
        }
        
    }
}

