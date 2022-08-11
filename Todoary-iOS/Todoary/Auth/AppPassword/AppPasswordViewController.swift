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
    
    var passwordArr : [String] = []
    
    var password : String = "1234"

    //text

    let appPwTitle = UILabel().then{
        $0.text = "암호 입력"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .header)
    }
    
    let appPwtext = UILabel().then{
        $0.text = "암호를 입력해 주세요"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body1)
        $0.isHidden = false
    }
    
    let pwnotcorrect = UILabel().then {
        $0.text = "다시 입력해 주세요"
        $0.textColor = .headline
        $0.font = UIFont.nbFont(type: .body1)
        $0.isHidden = true
    }
    
    //MARK: - input not password
    let inputNotPw1 = UIImageView().then{
        $0.image = UIImage(named: "inputNotPassword")
    }
    
    let inputNotPw2 = UIImageView().then{
        $0.image = UIImage(named: "inputNotPassword")
    }
    
    let inputNotPw3 = UIImageView().then{
        $0.image = UIImage(named: "inputNotPassword")
    }
    
    let inputNotPw4 = UIImageView().then{
        $0.image = UIImage(named: "inputNotPassword")
    }
    
    //MARK: - input password
    let inputPw1 = UIImageView().then{
        $0.image = UIImage(named: "password1")
        $0.isHidden = true
    }
    
    let inputPw2 = UIImageView().then{
        $0.image = UIImage(named: "password2")
        $0.isHidden = true
    }
    
    let inputPw3 = UIImageView().then{
        $0.image = UIImage(named: "password3")
        $0.isHidden = true
    }
    
    let inputPw4 = UIImageView().then{
        $0.image = UIImage(named: "password4")
        $0.isHidden = true
    }
    
    //MARK: - numbutton
    //button
    
    let numBtn1 =  UIButton().then{
        $0.setTitle( "1", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
    }
    
    let numBtn2 =  UIButton().then{
        $0.setTitle( "2", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
    }
    
        
    let numBtn3 =  UIButton().then{
        $0.setTitle( "3", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
    }
        
    let numBtn4 =  UIButton().then{
        $0.setTitle( "4", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
    }

    let numBtn5 =  UIButton().then{
        $0.setTitle( "5", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
    }
    
    let numBtn6 =  UIButton().then{
        $0.setTitle( "6", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
    }
    
    let numBtn7 =  UIButton().then{
        $0.setTitle( "7", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
    }
    
    let numBtn8 =  UIButton().then{
        $0.setTitle( "8", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
    }
    
    let numBtn9 =  UIButton().then{
        $0.setTitle( "9", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
    }
    
    let numBtn0 =  UIButton().then{
        $0.setTitle( "0", for: .normal)
        $0.backgroundColor = .numberBtnColor
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.nbFont(type: .numberBtn)
        $0.addTarget(self, action: #selector(numBtndidtab), for: .touchUpInside)
    }
    
    let blueCharacter = UIImageView().then{
//        $0.image = UIImage(named: <#T##String#>)
        $0.backgroundColor = .black
    }

 
    //MARK: - UIComponenets_deletBtn
    let deletBtn = UIButton().then{
        $0.setImage(UIImage(systemName: "delete.backward"), for: .normal)
        $0.tintColor = .black
        $0.contentMode = .scaleToFill
        $0.addTarget(self, action: #selector(deletBtndidtab), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setUpView()
        setUpConstraint()
    }
    
    
       //MARK: - numbtndidtab
    
    @objc func numBtndidtab(sender : UIButton) {
        let numdigit = sender.currentTitle!
        passwordArr.append(numdigit)
        
        let pwarraycount = passwordArr.count
        
        switch pwarraycount {
        case 1 :
            inputPw1.isHidden = false

        case 2 :
            inputPw2.isHidden = false

        case 3 :
            inputPw3.isHidden = false
     
        case 4 :
            inputPw4.isHidden = false
            
            let pw = passwordArr.joined(separator: "")
            if password == pw
                && inputPw1.isHidden == false
                && inputPw2.isHidden == false
                && inputPw3.isHidden == false
                && inputPw4.isHidden == false {
                
                //이미지 보이기 위한 딜레이
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    self.navigationController?.pushViewController(HomeViewController(), animated: true)
                }
            } else {
                passwordArr.removeAll()
                appPwtext.isHidden = true
                pwnotcorrect.isHidden = false
                
                //이미지 보이기 위한 딜레이

                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [self] in
                    
                    inputPw1.isHidden = true
                    inputPw2.isHidden = true
                    inputPw3.isHidden = true
                    inputPw4.isHidden = true
                }
            }
            
        default:
            return
        }
    }
    
    @objc
    func deletBtndidtab(sender : UIButton) {
        
        let pwarraycount = passwordArr.count
        
        if deletBtn.isTouchInside {
            switch pwarraycount {
            case 4 :
                inputPw4.isHidden = true
                passwordArr.removeLast()
                print(passwordArr)
            case 3 :
                inputPw3.isHidden = true
                passwordArr.removeLast()
                print(passwordArr)
        case 2 :
            inputPw2.isHidden = true
            passwordArr.removeLast()
                print(passwordArr)
        case 1 :
            inputPw1.isHidden = true
            passwordArr.removeLast()
                print(passwordArr)

        default :
            return
            }
        }
    }
}



