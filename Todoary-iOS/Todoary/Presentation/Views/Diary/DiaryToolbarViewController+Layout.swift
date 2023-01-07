//
//  DiaryToolbarViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/08/04.
//

import Foundation
import UIKit
import SnapKit

extension DiaryToolbar {
    
    func setUpView(){
        self.addSubview(backToolbar)

    }
    
    
    func setUpConstraint(){
        
        backToolbar.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(92)
        }
        
        backToolbar.addSubview(firstToolbar)
        
        firstToolbar.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(46)
            make.bottom.equalToSuperview()
        }
        
        firstToolbar.addSubview(firstStackView)

        firstStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        firstStackView.addArrangedSubview(cameraBtn)
        firstStackView.addArrangedSubview(textBtn)
        firstStackView.addArrangedSubview(stickerBtn)
        firstStackView.addArrangedSubview(highlightBtn)
        firstStackView.addArrangedSubview(exitBtn)
        
        cameraBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
        }
        
        textBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
        }
        
        stickerBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
        }
        
        highlightBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
        }
        
        exitBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
        }
        
        backToolbar.addSubview(colorToolbar)
        
        colorToolbar.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(46)
            make.top.equalToSuperview()
        }
        
        colorToolbar.addSubview(colorStackView)
        
        colorStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        colorStackView.addArrangedSubview(yellowBtn)
        colorStackView.addArrangedSubview(orangeBtn)
        colorStackView.addArrangedSubview(redBtn)
        colorStackView.addArrangedSubview(greenBtn)
        colorStackView.addArrangedSubview(blueBtn)
        colorStackView.addArrangedSubview(grayBtn)
        
        yellowBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
//            make.centerY.equalTo(colorToolbar)
//            make.trailing.equalTo(orangeBtn.snp.leading).offset(-30)
        }
        
        orangeBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
//            make.centerY.equalTo(colorToolbar)
//            make.trailing.equalTo(redBtn.snp.leading).offset(-30)
        }
        
        redBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
//            make.centerY.equalTo(colorToolbar)
//            make.centerX.equalToSuperview().offset(-29)
        }
        
        greenBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
//            make.centerY.equalToSuperview()
//            make.centerX.equalToSuperview().offset(29)
        }
        
        blueBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
//            make.centerY.equalTo(colorToolbar)
//            make.leading.equalTo(greenBtn.snp.trailing).offset(30)
        }
        
        grayBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(28)
//            make.centerY.equalTo(colorToolbar)
//            make.leading.equalTo(blueBtn.snp.trailing).offset(30)
        }
        
        backToolbar.addSubview(textToolbar)
        
        textToolbar.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalTo(46)
            make.top.equalToSuperview()
        }
        
        textToolbar.addSubview(textStackView)
        
        textStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        textStackView.addArrangedSubview(alignLeftBtn)
        textStackView.addArrangedSubview(ailgnCenterBtn)
        textStackView.addArrangedSubview(alignRightBtn)
        textStackView.addArrangedSubview(fontBtn)
        textStackView.addArrangedSubview(strikeLineBtn)
        textStackView.addArrangedSubview(underLineBtn)
        textStackView.addArrangedSubview(boldBtn)

        alignLeftBtn.snp.makeConstraints{make in
            make.width.height.equalTo(24)
        }

        ailgnCenterBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(24)
        }

        alignRightBtn.snp.makeConstraints{make in
            make.width.height.equalTo(24)
        }
        
        fontBtn.snp.makeConstraints{make in
            make.width.equalTo(19)
        }

        strikeLineBtn.snp.makeConstraints{make in
            make.width.equalTo(14)
        }

        underLineBtn.snp.makeConstraints{make in
            make.width.equalTo(13)
        }

        boldBtn.snp.makeConstraints{make in
            make.width.equalTo(14)
        }
        
        backToolbar.addSubview(fontToolbar)
        
        fontToolbar.snp.makeConstraints{make in
            make.width.equalToSuperview()
            make.height.equalTo(46)
            make.top.equalToSuperview()
        }
        
        fontToolbar.addSubview(fontStackView)
        
        fontStackView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        fontStackView.addArrangedSubview(fontBtn1)
        fontStackView.addArrangedSubview(fontBtn2)
        fontStackView.addArrangedSubview(fontBtn3)
        fontStackView.addArrangedSubview(fontBtn4)
        fontStackView.addArrangedSubview(fontBtn5)
        
        fontBtn1.snp.makeConstraints{make in
            make.width.equalTo(58)
            make.height.equalTo(22)
        }
        
        fontBtn2.snp.makeConstraints{make in
            make.width.equalTo(63)
            make.height.equalTo(22)
        }
        
        fontBtn3.snp.makeConstraints{make in
            make.width.equalTo(63)
            make.height.equalTo(22)
        }
        
        fontBtn4.snp.makeConstraints{make in
            make.width.equalTo(57)
            make.height.equalTo(22)
        }
        
        fontBtn5.snp.makeConstraints{make in
            make.width.equalTo(55)
            make.height.equalTo(22)
        }
    }
}

