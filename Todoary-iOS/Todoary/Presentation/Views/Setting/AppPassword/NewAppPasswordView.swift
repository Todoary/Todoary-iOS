//
//  NewAppPasswordViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/08/12.
//

import Foundation
import UIKit
import SnapKit

class NewAppPasswordView: BaseView {
    
    let appPwTitle = UILabel().then{
        $0.text = "암호 입력"
        $0.textColor = .headline
        $0.setTypoStyleWithSingleLine(typoStyle: .semibold18)
    }
    
    let newAppPwtext = UILabel().then{
        $0.text = "새로운 암호를 입력해 주세요"
        $0.textColor = .headline
        $0.setTypoStyleWithSingleLine(typoStyle: .medium14_16)
        $0.isHidden = false
    }
    
    let newAppPwtext2 = UILabel().then {
        $0.text = "한 번 더 입력해 주세요"
        $0.textColor = .headline
        $0.setTypoStyleWithSingleLine(typoStyle: .medium14_16)
        $0.isHidden = true
    }
    
    let pwnotcorrect = UILabel().then {
        $0.text = "다시 입력해 주세요"
        $0.textColor = .headline
        $0.setTypoStyleWithSingleLine(typoStyle: .medium14_16)
        $0.isHidden = true
    }
    
    //MARK: - input not password
    
    let inputNotPw = UIStackView().then{
        $0.axis = .horizontal
    }
    
    let inputNotPw1 = UIImageView().then{
        $0.image = Image.inputNotPassword
    }
    
    let inputNotPw2 = UIImageView().then{
        $0.image = Image.inputNotPassword
    }
    
    let inputNotPw3 = UIImageView().then{
        $0.image = Image.inputNotPassword
    }
    
    let inputNotPw4 = UIImageView().then{
        $0.image = Image.inputNotPassword
    }
    
    //MARK: - input password
    
    let inputPw = UIStackView().then{
        $0.axis = .horizontal
    }
    
    let inputPw1 = UIImageView().then{
        $0.image = Image.password1
        $0.isHidden = true
    }
    
    let inputPw2 = UIImageView().then{
        $0.image = Image.password2
        $0.isHidden = true
    }
    
    let inputPw3 = UIImageView().then{
        $0.image = Image.password3
        $0.isHidden = true
    }
    
    let inputPw4 = UIImageView().then{
        $0.image = Image.password4
        $0.isHidden = true
    }
    
    //MARK: - numbutton
    
    let numbutton = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 39
    }
    
    let numbuttonStackView1 = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 60
    }
    
    let numbuttonStackView2 = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 60
    }
    
    let numbuttonStackView3 = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 60
    }
    
    let numbuttonStackView4 = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 60
    }
    
    //button
    let numBtn1 =  UIButton().then{
        $0.setTitle( "1", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(Image.homeProfile, for: UIControl.State.highlighted)
    }
    
    let numBtn2 =  UIButton().then{
        $0.setTitle( "2", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(Image.homeProfile, for: UIControl.State.highlighted)
    }
    
        
    let numBtn3 =  UIButton().then{
        $0.setTitle( "3", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(Image.homeProfile, for: UIControl.State.highlighted)
    }
        
    let numBtn4 =  UIButton().then{
        $0.setTitle( "4", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(Image.homeProfile, for: UIControl.State.highlighted)
    }

    let numBtn5 =  UIButton().then{
        $0.setTitle( "5", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(Image.homeProfile, for: UIControl.State.highlighted)
    }
    
    let numBtn6 =  UIButton().then{
        $0.setTitle( "6", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(Image.homeProfile, for: UIControl.State.highlighted)
    }
    
    let numBtn7 =  UIButton().then{
        $0.setTitle( "7", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(Image.homeProfile, for: UIControl.State.highlighted)
    }
    
    let numBtn8 =  UIButton().then{
        $0.setTitle( "8", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(Image.homeProfile, for: UIControl.State.highlighted)
    }
    
    let numBtn9 =  UIButton().then{
        $0.setTitle( "9", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(Image.homeProfile, for: UIControl.State.highlighted)
    }
    
    let numBtn0 =  UIButton().then{
        $0.setTitle( "0", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.setBackgroundImage(Image.homeProfile, for: UIControl.State.highlighted)
    }
    
    let blueCharacterView = UIView().then{
        $0.backgroundColor = nil
    }
    
    let blueCharacter = UIImageView().then{
        $0.image = Image.password5
    }

 
    //MARK: - UIComponenets_deletBtn
    let deletBtn = UIButton().then{
        $0.setImage(Image.backspace, for: .normal)
        $0.tintColor = .black
        $0.contentMode = .scaleToFill
    }
    
    override func hierarchy(){
        
        self.addSubview(appPwTitle)
        self.addSubview(newAppPwtext)
        self.addSubview(newAppPwtext2)
        self.addSubview(pwnotcorrect)
        
        self.addSubview(inputNotPw)
        self.addSubview(inputNotPw1)
        self.addSubview(inputNotPw2)
        self.addSubview(inputNotPw3)
        self.addSubview(inputNotPw4)
        
        self.addSubview(inputPw)
        self.addSubview(inputPw1)
        self.addSubview(inputPw2)
        self.addSubview(inputPw3)
        self.addSubview(inputPw4)
        
        self.addSubview(numbutton) //StackView
        numbutton.addArrangedSubview(numbuttonStackView1)
        numbutton.addArrangedSubview(numbuttonStackView2)
        numbutton.addArrangedSubview(numbuttonStackView3)
        numbutton.addArrangedSubview(numbuttonStackView4)
        
        self.addSubview(numBtn1)
        self.addSubview(numBtn2)
        self.addSubview(numBtn3)
        self.addSubview(numBtn4)
        self.addSubview(numBtn5)
        self.addSubview(numBtn6)
        self.addSubview(numBtn7)
        self.addSubview(numBtn8)
        self.addSubview(numBtn9)
        self.addSubview(numBtn0)
        self.addSubview(blueCharacter)
        self.addSubview(deletBtn)
        
    }

    override func layout(){
        
        //text
        appPwTitle.snp.makeConstraints{ make in
            let offset = Const.Device.isSmallDevice ? 30 : 76
            make.top.equalToSuperview().offset(offset)
            make.centerX.equalToSuperview()
        }
        
        newAppPwtext.snp.makeConstraints{ make in
            make.top.equalTo(appPwTitle.snp.bottom).offset(16)
            make.width.equalTo(161)
            make.height.equalTo(17)
            make.centerX.equalTo(appPwTitle)
        }
        
        newAppPwtext2.snp.makeConstraints{ make in
            make.top.equalTo(appPwTitle.snp.bottom).offset(16)
            make.width.equalTo(128)
            make.height.equalTo(17)
            make.centerX.equalTo(appPwTitle)
        }
        pwnotcorrect.snp.makeConstraints{ make in
            make.top.equalTo(appPwTitle.snp.bottom).offset(16)
            make.centerX.equalTo(appPwTitle)
        }
        
        //inputNotPassword img
        
        //inputNotPassword img
        
        inputNotPw.snp.makeConstraints{ make in
            let offset = Const.Device.isSmallDevice ? 40 : 92
            make.top.equalTo(newAppPwtext.snp.bottom).offset(offset)
            make.centerX.equalToSuperview()
            make.width.equalTo(208)
            make.height.equalTo(40)
        }
        
        inputNotPw.addSubview(inputNotPw1)
        inputNotPw.addSubview(inputNotPw2)
        inputNotPw.addSubview(inputNotPw3)
        inputNotPw.addSubview(inputNotPw4)
        
        inputNotPw1.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()

        }
        
        inputNotPw2.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputNotPw1.snp.trailing).offset(16)
            make.centerY.equalToSuperview()

        }
        
        inputNotPw3.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputNotPw2.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        inputNotPw4.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputNotPw3.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        //inputPassword img
        
        inputPw.snp.makeConstraints{ make in
            make.width.equalTo(208)
            make.height.equalTo(40)
            make.top.equalTo(newAppPwtext.snp.bottom).offset(92)
            make.centerX.equalToSuperview()
        }
        
        inputNotPw.addSubview(inputPw1)
        inputNotPw.addSubview(inputPw2)
        inputNotPw.addSubview(inputPw3)
        inputNotPw.addSubview(inputPw4)
        
        inputPw1.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        inputPw2.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputPw1.snp.trailing).offset(16)
            make.centerY.equalToSuperview()

        }
        
        inputPw3.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputPw2.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        inputPw4.snp.makeConstraints{ make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.leading.equalTo(inputPw3.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        
        
    
            //button
            
            numbutton.snp.makeConstraints{ make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().offset(-95)
            }
            
            numbuttonStackView1.snp.makeConstraints{ make in
                make.centerX.equalToSuperview()
            }
            
            numbuttonStackView1.addArrangedSubview(numBtn1)
            numbuttonStackView1.addArrangedSubview(numBtn2)
            numbuttonStackView1.addArrangedSubview(numBtn3)
            
            numBtn1.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            numBtn2.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            numBtn3.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            numbuttonStackView2.snp.makeConstraints{ make in
                make.width.equalTo(249)
                make.height.equalTo(44)
                make.centerX.equalToSuperview()
            }
            
            numbuttonStackView2.addArrangedSubview(numBtn4)
            numbuttonStackView2.addArrangedSubview(numBtn5)
            numbuttonStackView2.addArrangedSubview(numBtn6)
            
            numBtn4.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            numBtn5.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            numBtn6.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            numbuttonStackView3.snp.makeConstraints{ make in
                make.centerX.equalToSuperview()
            }
            
            numbuttonStackView3.addArrangedSubview(numBtn7)
            numbuttonStackView3.addArrangedSubview(numBtn8)
            numbuttonStackView3.addArrangedSubview(numBtn9)
            
            numBtn7.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            numBtn8.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            numBtn9.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            numbuttonStackView4.snp.makeConstraints{ make in
                make.centerX.equalToSuperview()
            }
            
            numbuttonStackView4.addArrangedSubview(blueCharacterView)
            numbuttonStackView4.addArrangedSubview(numBtn0)
            numbuttonStackView4.addArrangedSubview(deletBtn)
            
            numBtn0.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            blueCharacterView.addSubview(blueCharacter)
            
            blueCharacterView.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
            
            
            blueCharacter.snp.makeConstraints{ make in
                make.width.height.equalTo(40)
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        
            deletBtn.snp.makeConstraints{ make in
                make.width.height.equalTo(43)
            }
        }
    }
}
