//
//  DiaryStickerViewController + Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/08/11.
//

import Foundation
import UIKit
import SnapKit
import Then
import IRSticker_swift

class DiaryStickerView : UIView{

    //MARK: - Properties

    var DiaryStickerCollectionViewCellid = "DiaryStickerCollectionViewCellid"
    
    var collectionView: UICollectionView!
    
    //MARK: - Lifecycles
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        
        configure()
        setupCollectionView()
    }
    
    required init?(corder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //컬렉션뷰 layout
    func configure() {
        
        let collectionViewLayer = UICollectionViewFlowLayout()
        collectionViewLayer.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayer)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = UIColor (
            red: 230/255,
            green: 230/255,
            blue: 230/255,
            alpha: 1
        )
        
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().offset(0)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        //CollectionView 등록
        collectionView.register(DiaryStickerCollectionViewCell.self, forCellWithReuseIdentifier: DiaryStickerCollectionViewCellid)
    }
}
        
//MARK: - Helpers


extension DiaryStickerView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

//셀 개수
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 16
}

//셀 초기값 설정
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: DiaryStickerCollectionViewCellid,
        for: indexPath) as? DiaryStickerCollectionViewCell else {
            fatalError("셀 타입 케스팅 실패")
        }
    
    cell.stickerBtn.image = DiaryViewController.stickerData[indexPath.row]
    cell.backgroundColor = UIColor (
        red: 230/255,
        green: 230/255,
        blue: 230/255,
        alpha: 1
    )
    
    return cell
}

//셀 사이즈
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 97.5, height: 101.5)
}

//셀 위아래 간격
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return CGFloat(0)
}

//셀 양옆 간격
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return CGFloat(0)
}



//MARK: - UICollectionViewDelegate

////셀 선택o
//func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    guard let cell = collectionView.cellForItem(at:indexPath) as? DiaryStickerCollectionViewCell else{
//        fatalError()
//    }
//}
//
////셀 선택x
//func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//    guard let cell = collectionView.cellForItem(at:indexPath) as? DiaryStickerCollectionViewCell else{
//        fatalError()
//    }
//}
}



