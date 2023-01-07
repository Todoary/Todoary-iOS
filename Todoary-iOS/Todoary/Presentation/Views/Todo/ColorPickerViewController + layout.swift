//
//  ColorPickerViewController + layout.swift
//  Todoary
//
//  Created by 예리 on 2022/07/24.
//

import Foundation

extension ColorPickerViewController {
    
    func setUpView(){
        
        self.view.addSubview(deleteBtn)
        self.view.addSubview(categoryTitle)
        self.view.addSubview(colorview)
        self.view.addSubview(completeBtn)
    }
    
    
    func setUpConstraint(){
        
        deleteBtn.snp.makeConstraints{ make in
            make.width.equalTo(61)
            make.height.equalTo(55)
            make.top.equalTo(42)
            make.leading.equalTo(311)
        }
        
        categoryTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(120)
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
        
        completeBtn.snp.makeConstraints{ make in
            make.top.equalTo(colorview.snp.bottom).offset(20)
            make.width.equalTo(326)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
        }
        
    }
}

