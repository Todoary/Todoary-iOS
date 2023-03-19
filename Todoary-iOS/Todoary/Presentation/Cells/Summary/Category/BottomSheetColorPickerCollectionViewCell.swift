//
//  BottomSheetColorPickerCollectionViewCell.swift
//  Todoary
//
//  Created by 박소윤 on 2023/03/19.
//

import Foundation

class BottomSheetColorPickerCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - UIComponenets

    let colorPickBorderView = UIView().then{
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = Const.Device.isSmallDevice ? 35.0 / 2 : 40/2
        $0.isHidden = true
        $0.isUserInteractionEnabled = true

    }

    //MARK: - layout
    
    override func hierarchy() {
        super.hierarchy()
        baseView.addSubview(colorPickBorderView)
    }
    
    override func layout() {
        super.layout()
        colorPickBorderView.snp.makeConstraints{
            let size = Const.Device.isSmallDevice ? 35 : 40
            $0.width.height.equalTo(size)
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
