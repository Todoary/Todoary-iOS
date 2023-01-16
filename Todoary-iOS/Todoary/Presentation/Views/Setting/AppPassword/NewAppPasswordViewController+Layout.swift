//
//  NewAppPasswordViewController+Layout.swift
//  Todoary
//
//  Created by 예리 on 2022/08/12.
//

import Foundation
import UIKit
import SnapKit

extension NewAppPasswordViewController {
    
    func setUpView(){
        
        self.view.addSubview(navigatonView)
        
        self.view.addSubview(appPwTitle)
        self.view.addSubview(newAppPwtext)
        self.view.addSubview(newAppPwtext2)
        self.view.addSubview(pwnotcorrect)
        
        self.view.addSubview(inputNotPw)
        self.view.addSubview(inputNotPw1)
        self.view.addSubview(inputNotPw2)
        self.view.addSubview(inputNotPw3)
        self.view.addSubview(inputNotPw4)
        
        self.view.addSubview(inputPw)
        self.view.addSubview(inputPw1)
        self.view.addSubview(inputPw2)
        self.view.addSubview(inputPw3)
        self.view.addSubview(inputPw4)
        
        self.view.addSubview(numbutton) //StackView
        numbutton.addArrangedSubview(numbuttonStackView1)
        numbutton.addArrangedSubview(numbuttonStackView2)
        numbutton.addArrangedSubview(numbuttonStackView3)
        numbutton.addArrangedSubview(numbuttonStackView4)
        
        self.view.addSubview(numBtn1)
        self.view.addSubview(numBtn2)
        self.view.addSubview(numBtn3)
        self.view.addSubview(numBtn4)
        self.view.addSubview(numBtn5)
        self.view.addSubview(numBtn6)
        self.view.addSubview(numBtn7)
        self.view.addSubview(numBtn8)
        self.view.addSubview(numBtn9)
        self.view.addSubview(numBtn0)
        self.view.addSubview(blueCharacter)
        self.view.addSubview(deletBtn)
        
    }

    func setUpConstraint(){
        
        navigatonView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        //text
        appPwTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(140)
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
            make.width.equalTo(208)
            make.height.equalTo(40)
            make.top.equalTo(newAppPwtext.snp.bottom).offset(92)
            make.centerX.equalToSuperview()
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
//                make.width.equalTo(249)
//                make.height.equalTo(44)
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
//                make.width.equalTo(249)
//                make.height.equalTo(43)
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
