//
//  ColorPickerCollectionViewCell.swift
//  Todoary
//
//  Created by 예리 on 2022/07/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class ColorPickerCollectionViewCell: UICollectionViewCell {
    static let identifier = "ColorPickerCollectionViewCell"
    
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                colorBtnpick.isHidden = false
                colorBtnpick.layer.borderWidth = 2
                colorBtnpick.layer.cornerRadius = 40/2
                colorBtnpick.isUserInteractionEnabled = true
            }
            else{
                colorBtnpick.isHidden = true
                colorBtnpick.layer.borderWidth = 2
                colorBtnpick.layer.cornerRadius = 40/2
                colorBtnpick.isUserInteractionEnabled = true
            }
        }
    }
    
    //MARK: - UIComponenets
    
   
    let colorBtnpick = UIView().then{
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 40/2
        $0.isHidden = true
        $0.isUserInteractionEnabled = true

    }
   
    
    //MARK: - Lifecycles
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    
        setUpContentView()
        setUpConstraint()
    }

    //MARK: - layout
        func setUpContentView(){

            contentView.addSubview(colorBtnpick)
        }
            
        
        func setUpConstraint(){
            
            
            colorBtnpick.snp.makeConstraints{ make in
                make.width.height.equalTo(40)
                make.centerX.centerY.equalToSuperview()
                
            }
        }
            
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
