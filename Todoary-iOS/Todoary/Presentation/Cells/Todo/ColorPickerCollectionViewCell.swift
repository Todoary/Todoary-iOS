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
    
    
    //MARK: - UIComponenets
    
   
    let colorBtnpick = UIView().then{
        $0.layer.borderWidth = 2
        let cellSize: CGFloat = Const.Device.isSmallDevice ? 35 : 40
        $0.layer.cornerRadius = cellSize/2
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
            
            let cellSize: CGFloat = Const.Device.isSmallDevice ? 35 : 40
            colorBtnpick.snp.makeConstraints{ make in
                make.width.height.equalTo(cellSize)
                make.centerX.centerY.equalToSuperview()
                
            }
        }
            
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
