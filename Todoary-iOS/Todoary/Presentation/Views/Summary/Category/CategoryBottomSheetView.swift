//
//  CategoryBottomSheetView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/31.
//

import UIKit

class CategoryBottomSheetView: BaseView {
    
    private let isSmallDevice = Const.Device.isSmallDevice
    
    let categoryTextField = UITextField().then {
        $0.placeholder = "카테고리 이름을 입력해주세요"
        let typo: TypoStyle = Const.Device.isSmallDevice ? .bold11 : .bold13
        $0.textFieldTypoSetting(type: typo)
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
        let typo: TypoStyle = Const.Device.isSmallDevice ? .bold12 : .bold15_18
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: typo)
        let height: CGFloat = isSmallDevice ? 31 : 38
        $0.layer.cornerRadius = height / 2
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
        let typo: TypoStyle = Const.Device.isSmallDevice ? .bold12 : .bold15_18
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: typo)
        let height: CGFloat = isSmallDevice ? 31 : 38
        $0.layer.cornerRadius = height / 2
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowRadius = 10.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    let colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then{
        
        let flowLayout = UICollectionViewFlowLayout()
            .then{
            $0.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 10, right: 7)
        }
        
        $0.collectionViewLayout = flowLayout
        $0.isScrollEnabled = false
        $0.backgroundColor = .transparent
        
        $0.register(BottomSheetColorPickerCollectionViewCell.self, forCellWithReuseIdentifier: BottomSheetColorPickerCollectionViewCell.cellIdentifier)
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
            let height = isSmallDevice ? 38 : 46
            $0.height.equalTo(height)
            
        }
        
        colorCollectionView.snp.makeConstraints { make in
            let topOffset: CGFloat = isSmallDevice ? 21.33 : 26
            let height: CGFloat = isSmallDevice ? 135 : 150
            make.top.equalTo(categoryTextField.snp.bottom).offset(topOffset)
            make.leading.equalToSuperview().offset(45)
            make.width.equalTo(300)
            make.height.equalTo(height)
            make.centerX.equalToSuperview()
        }
        
        confirmBtn.snp.makeConstraints{ make in
            let bottomOffset = isSmallDevice ? 20 : 34
            let width = isSmallDevice ? 76 : 93
            let height = isSmallDevice ? 31 : 38
            let topOffset = isSmallDevice ? 23 : 28
            make.bottom.equalToSuperview().inset(bottomOffset)
            make.top.equalTo(colorCollectionView.snp.bottom).offset(topOffset)
            make.leading.equalToSuperview().offset(66)
            make.width.equalTo(width)
            make.height.equalTo(height)
            
        }
        
        deleteBtn.snp.makeConstraints{ make in
            make.centerY.width.height.equalTo(confirmBtn)
            make.trailing.equalToSuperview().offset(-66)
        }
    }
}
