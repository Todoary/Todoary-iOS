//
//  DiaryToolbarViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/08/04.
//

import Foundation
import UIKit
import SnapKit
import Then


class DiaryToolbar : UIView {
    

    //MARK: - UIComponenets
    
    var DiarySticker = DiaryStickerView()
    
    let backToolbar = UIView().then{
        $0.backgroundColor = .none
    }
    
    let cameraBtn = UIButton().then{
        $0.setImage(UIImage(named: "camera"), for: .normal)
        $0.addTarget(self, action: #selector(cameraBtnDidTab), for: .touchUpInside)
    }
    
    let textBtn = UIButton().then{
        $0.setImage(UIImage(named: "type"), for: .normal)
        $0.addTarget(self, action: #selector(textBtnDidTab), for: .touchUpInside)
        $0.addTarget(self, action: #selector(fontBtnDidTab), for: .touchUpInside)
    }
    
    let stickerBtn = UIButton().then{
        $0.setImage(UIImage(named: "smile"), for: .normal)
    }
    
    let highlightBtn = UIButton().then{
        $0.setImage(UIImage(named: "edit"), for: .normal)
        $0.addTarget(self, action: #selector(highlightBtnDidTab), for: .touchUpInside)
        $0.addTarget(self, action: #selector(fontBtnDidTab), for: .touchUpInside)
    }
    
    let exitBtn = UIButton().then{
        $0.setImage(UIImage(named: "x"), for: .normal)
    }
    
    let firstStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.spacing = 54
    }
    
    let firstToolbar = UIView().then{
        $0.backgroundColor = UIColor(
            red: 230/255,
            green: 230/255,
            blue: 230/255,
            alpha: 1
        )
        $0.layer.borderColor = UIColor(
            red: 198/255,
            green: 198/255,
            blue: 198/255,
            alpha: 1
        ).cgColor
        $0.layer.borderWidth = 0.8
    }
    
    //MARK: - UIComponenets_colorToolbar
    
    let yellowBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 254/255,
            green: 210/255,
            blue: 90/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let orangeBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 255/255,
            green: 143/255,
            blue: 84/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let redBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 234/255,
            green: 44/255,
            blue: 4/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let greenBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 172/255,
            green: 215/255,
            blue: 134/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let blueBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 86/255,
            green: 152/255,
            blue: 255/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let grayBtn = UIButton().then{
        $0.backgroundColor = UIColor(
            red: 184/255,
            green: 184/255,
            blue: 184/255,
            alpha: 1
        )
        $0.layer.cornerRadius = 28/2
    }
    
    let colorStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.spacing = 30
    }
    
    let colorToolbar = UIView().then{
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.silver_225.cgColor
        $0.layer.borderWidth = 1
    }
    
    //MARK: - UIComponenets_textToolbar
    
    let alignLeftBtn = UIButton().then{
        $0.setImage(UIImage(named: "align-left"), for: .normal)
    }
    
    let ailgnCenterBtn = UIButton().then{
        $0.setImage(UIImage(named: "align-center"), for: .normal)
    }
    
    let alignRightBtn = UIButton().then{
        $0.setImage(UIImage(named: "align-right"), for: .normal)
    }
    
    let fontBtn = UIButton().then{
        $0.setImage(UIImage(named: "ga"), for: .normal)
        $0.addTarget(self, action: #selector(fontBtnDidTab), for: .touchUpInside)
    }
    
    let strikeLineBtn = UIButton().then{
        $0.setImage(UIImage(named: "T"), for: .normal)
    }
    
    let underLineBtn = UIButton().then{
        $0.setImage(UIImage(named: "U"), for: .normal)
    }
    
    let boldBtn = UIButton().then{
        $0.setImage(UIImage(named: "B"), for: .normal)
    }
    
    let textStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.spacing = 32
    }
    
    let textToolbar = UIView().then{
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.silver_225.cgColor
        $0.layer.borderWidth = 1
    }
    
    //MARK: - UIComponenets_fontToolbar
    
    let fontBtn1 = UIButton().then{
        $0.setImage(UIImage(named: "abcd1"), for: .normal)
    }
    
    let fontBtn2 = UIButton().then{
        $0.setImage(UIImage(named: "abcd2"), for: .normal)
    }
    
    let fontBtn3 = UIButton().then{
        $0.setImage(UIImage(named: "abcd3"), for: .normal)
    }
    
    let fontBtn4 = UIButton().then{
        $0.setImage(UIImage(named: "abcd4"), for: .normal)
    }
    
    let fontBtn5 = UIButton().then{
        $0.setImage(UIImage(named: "abcd5"), for: .normal)
    }
    
    let fontStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.spacing = 13
    }
    
    let fontToolbar = UIView().then{
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.silver_225.cgColor
        $0.layer.borderWidth = 1
    }
    
    //MARK: - Lifecycles
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    
        setUpView()
        setUpConstraint()
    }
    
    required init?(corder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - BtnDidTab
    
    @objc func cameraBtnDidTab() {
//        사진 기능 추가시 코드 넣어주기
        if cameraBtn.isTouchInside == true {
            colorToolbar.isHidden = true
            textToolbar.isHidden = true
            fontToolbar.isHidden = true
        }
    }
    
    @objc func textBtnDidTab() {
        if textBtn.isTouchInside == true {
            textToolbar.isHidden = false
            colorToolbar.isHidden = true
        } else {
            textToolbar.isHidden = true
        }
    }
    
    @objc func fontBtnDidTab() {
        if fontBtn.isTouchInside == true {
            textToolbar.isHidden = true
            fontToolbar.isHidden = false
        } else {
            fontToolbar.isHidden = true
        }
    }
    
    @objc func highlightBtnDidTab() {
        if highlightBtn.isTouchInside == true {
            colorToolbar.isHidden = false
            textToolbar.isHidden = true
        } else {
            colorToolbar.isHidden = true
        }
    }
}

