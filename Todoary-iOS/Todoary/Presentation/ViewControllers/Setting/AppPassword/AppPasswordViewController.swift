//
//  AppPasswordViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/07/02.
//

import Foundation
import UIKit
import SnapKit
import Then

class AppPasswordViewController : UIViewController {
    
    //MARK: - UIComponenets
    
    let mainView = AppPasswordView()
    
    let defaults = UserDefaults.standard
    
    var passwordArr : [String] = []

    //text

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        style()
        layout()
        initialize()
    }
    
    //MARK: - BaseProtocol
    
    func style() {
    }
    
    func layout() {
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func initialize() {
        
        mainView.numBtn1.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
        mainView.numBtn2.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
        mainView.numBtn3.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
        mainView.numBtn4.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
        mainView.numBtn5.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
        mainView.numBtn6.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
        mainView.numBtn7.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
        mainView.numBtn8.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
        mainView.numBtn9.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
        mainView.numBtn0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
        mainView.deletBtn.addTarget(self, action: #selector(deletBtndidtab), for: .touchUpInside)
        
    }
    
    
    //MARK: - Actions
    
    @objc func numBtndidtab(sender : UIButton) {
        let numdigit = sender.currentTitle!
        passwordArr.append(numdigit)
        
        print(UserDefaults.standard.stringArray(forKey: "newPasswordArr"))
        
        let pwarraycount = passwordArr.count
        
        switch pwarraycount {
        case 1 :
            mainView.inputNotPw1.isHidden = true
            mainView.inputPw1.isHidden = false

        case 2 :
            mainView.inputNotPw2.isHidden = true
            mainView.inputPw2.isHidden = false

        case 3 :
            mainView.inputNotPw3.isHidden = true
            mainView.inputPw3.isHidden = false
     
        case 4 :
            mainView.inputNotPw4.isHidden = true
            mainView.inputPw4.isHidden = false
            
            let pw = UserManager.appPassword
            if passwordArr == pw
                && mainView.inputPw1.isHidden == false
                && mainView.inputPw2.isHidden == false
                && mainView.inputPw3.isHidden == false
                && mainView.inputPw4.isHidden == false {
                
                //이미지 보이기 위한 딜레이
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    
                    self.navigationController?.pushViewController(HomeViewController(), animated: true)
                }
                
                
            } else {
                passwordArr.removeAll()
                mainView.appPwtext.isHidden = true
                mainView.pwnotcorrect.isHidden = false
                
                //이미지 보이기 위한 딜레이

                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [self] in
                    
                    mainView.inputNotPw1.isHidden = false
                    mainView.inputNotPw2.isHidden = false
                    mainView.inputNotPw3.isHidden = false
                    mainView.inputNotPw4.isHidden = false
                    
                    mainView.inputPw1.isHidden = true
                    mainView.inputPw2.isHidden = true
                    mainView.inputPw3.isHidden = true
                    mainView.inputPw4.isHidden = true
                }
            }
            
        default:
            return
        }
    }
    
    @objc
    func deletBtndidtab(sender : UIButton) {
        
        let pwarraycount = passwordArr.count
        
        if mainView.deletBtn.isTouchInside {
            switch pwarraycount {
            case 4 :
                mainView.inputNotPw4.isHidden = false
                mainView.inputPw4.isHidden = true
                passwordArr.removeLast()
                print(passwordArr)
            case 3 :
                mainView.inputNotPw3.isHidden = false
                mainView.inputPw3.isHidden = true
                passwordArr.removeLast()
                print(passwordArr)
            case 2 :
                mainView.inputNotPw2.isHidden = false
                mainView.inputPw2.isHidden = true
                passwordArr.removeLast()
                print(passwordArr)
            case 1 :
                mainView.inputNotPw1.isHidden = false
                mainView.inputPw1.isHidden = true
                passwordArr.removeLast()
                print(passwordArr)
                
            default :
                return
            }
        }
    }
}



