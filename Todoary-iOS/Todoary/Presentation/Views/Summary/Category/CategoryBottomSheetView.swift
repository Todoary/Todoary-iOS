//
//  CategoryBottomSheetView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/31.
//

import UIKit

class CategoryBottomSheetView: BaseView {
    
    let categoryTextField = UITextField().then {
        $0.placeholder = "카테고리 이름을 입력해주세요"
        $0.font = UIFont.nbFont(ofSize: 13, weight: .bold)
        $0.setPlaceholderColor(.todoaryGrey)
        $0.addLeftPadding(padding: 17)
        //그림자
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    lazy var confirmBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: .bold15_18)
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    lazy var deleteBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: .bold15_18)
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    let colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then{
        
        let flowLayout = UICollectionViewFlowLayout().then{
            $0.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        }
        
        $0.collectionViewLayout = flowLayout
        $0.isScrollEnabled = false
        $0.backgroundColor = .transparent
        
        $0.register(ColorPickerCollectionViewCell.self, forCellWithReuseIdentifier: ColorPickerCollectionViewCell.identifier)
    }
    
    override func hierarchy() {
        
        self.addSubview(categoryTextField)
        self.addSubview(colorCollectionView)
        self.addSubview(confirmBtn)
        self.addSubview(deleteBtn)
    }
    
    override func layout() {

        categoryTextField.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(46)
            
        }
        
        colorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryTextField.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(45)
            make.width.equalTo(290)
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
        }
        
        confirmBtn.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.top.equalTo(colorCollectionView.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(66)
            make.width.equalTo(93)
            make.height.equalTo(38)
            
        }
        
        deleteBtn.snp.makeConstraints{ make in
            make.centerY.width.height.equalTo(confirmBtn)
            make.trailing.equalToSuperview().offset(-66)
        }
    }
}
