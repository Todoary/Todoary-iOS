//
//  DiaryStickerCollectionViewCell.swift
//  Todoary
//
//  Created by 예리 on 2022/08/11.
//

import Foundation
import UIKit
import SnapKit
import Then

class DiaryStickerCollectionViewCell: UICollectionViewCell {
    static let identifier = "DiaryStickerCollectionViewCell"
    
    
    
    //MARK: - UIComponenets
    
   
    let stickerBtn = UIImageView().then{
        $0.image = UIImage(named : "sticker1")
    }
   
    
    //MARK: - Lifecycles
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    
        setUpContentView()
        setUpConstraint()
    }

    //MARK: - layout
        func setUpContentView(){
            
            contentView.addSubview(stickerBtn)
        }
            
        
        func setUpConstraint(){
            
            stickerBtn.snp.makeConstraints{ make in
                make.width.equalTo(97.5)
                make.height.equalTo(101.5)
                make.centerX.centerY.equalToSuperview()
            }
        }
            
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
