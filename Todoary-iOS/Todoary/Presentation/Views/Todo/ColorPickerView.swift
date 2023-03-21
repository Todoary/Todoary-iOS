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
        $0.returnKeyType = .done
        $0.enablesReturnKeyAutomatically = true
    }
    
    let colorview = UIView().then{
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.silver_217.cgColor
    }
    
    let confirmBtn = UIButton().then{
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .button1)
        $0.layer.borderColor = UIColor.silver_217.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
    }

    
    override func hierarchy(){
        self.addSubview(categoryTitle)
        self.addSubview(colorview)
        self.addSubview(confirmBtn)
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
            let height: CGFloat = Const.Device.isSmallDevice ? 160 : 196
            make.height.equalTo(height)
            make.centerX.equalToSuperview()
        }
        
        //button
        confirmBtn.snp.makeConstraints{ make in
            make.top.equalTo(colorview.snp.bottom).offset(20)
            make.leading.trailing.equalTo(colorview)
            make.height.equalTo(52)
        }
        
    }
}

