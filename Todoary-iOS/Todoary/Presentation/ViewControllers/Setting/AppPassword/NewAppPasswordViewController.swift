//
//  NewAppPasswordViewController.swift
//  Todoary
//
//  Created by 예리 on 2022/08/12.
//

import Foundation
import UIKit
import SnapKit
import Then

class NewAppPasswordViewController : BaseViewController {
    
    //MARK: - UIComponenets
    
    var passwordArr : [String] = []
    var passwordArr2 : [String] = []
    
    let defaults = UserDefaults.standard
    
    let mainView = NewAppPasswordView()
    
    var navigatonView : NavigationView!

    //text

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigatonView = NavigationView(frame: .zero, self.navigationController!)
        
        self.view.backgroundColor = .white

        style()
        layout()
        initialize()
    }
    
    //MARK: - BaseProtocol
    
    override func style() {
        super.style()
    }
    
    override func layout() {
        
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        mainView.numBtn1.do{
            $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        }
        mainView.numBtn2.do{
            $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        }
        mainView.numBtn3.do{
            $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        }
        mainView.numBtn4.do{
            $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        }
        mainView.numBtn5.do{
            $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        }
        mainView.numBtn6.do{
            $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        }
        mainView.numBtn7.do{
            $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        }
        mainView.numBtn8.do{
            $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        }
        mainView.numBtn9.do{
            $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        }
        mainView.numBtn0.do{
            $0.addTarget(self, action: #selector(firstPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(secondPwInput), for: .touchUpInside)
            $0.addTarget(self, action: #selector(wrongPwInput), for: .touchUpInside)
        }
        
        mainView.deletBtn.do{
            $0.addTarget(self, action: #selector(deletBtndidtab), for: .touchUpInside)
            $0.addTarget(self, action: #selector(deletBtndidtab2), for: .touchUpInside)
        }
    }
    
    
       //MARK: - Actions
    
    //비밀번호 처음 설정할 때
    
    @objc func firstPwInput(sender : UIButton) {
        
        if mainView.newAppPwtext.isHidden == false {
            
            //숫자버튼 누름면 타이틀 값(숫자) 배열에 저장
            let numdigit = sender.currentTitle!
            passwordArr.append(numdigit)
            
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
                print(passwordArr)
                
                //이미지 보이기 위한 딜레이
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [self] in
                    
                    mainView.newAppPwtext.isHidden = true
                    //비밀번호를 4자리 설정했다면, 비밀번화 확인 입력 문구 보이게 만들어주기
                    mainView.newAppPwtext2.isHidden = false
                    
                    mainView.inputNotPw1.isHidden = false
                    mainView.inputNotPw2.isHidden = false
                    mainView.inputNotPw3.isHidden = false
                    mainView.inputNotPw4.isHidden = false
                    
                    mainView.inputPw1.isHidden = true
                    mainView.inputPw2.isHidden = true
                    mainView.inputPw3.isHidden = true
                    mainView.inputPw4.isHidden = true
                }
            default:
                return
            }
        }
    }

    //비밀번호 같은지 확인하기
    
    @objc func secondPwInput(sender : UIButton) {
        
        
        if mainView.newAppPwtext2.isHidden == false {
            
            let numdigit = sender.currentTitle!
            //숫자버튼 누름면 타이틀 값(숫자) 배열에 저장, 비교를 위해 새로운 배열(passwordArr2)에 저장
            passwordArr2.append(numdigit)
            
            let pwarraycount = passwordArr2.count
            
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
                print(passwordArr)
                print(passwordArr2)
                
                //비밀번호 4자리 모두 입려했을 때, 처음 비밀번호 설정(passwordArr)과 확인 비밀번호 설정(passwordArr2)이 같은지 확인
                if passwordArr == passwordArr2 {
                    defaults.set(passwordArr2, forKey: "newPasswordArr")
//                    defaults.object(forKey: "newPasswordArr")
                    print(UserDefaults.standard.stringArray(forKey: "newPasswordArr"))
                    
                    let toast = ToastMessageView(message: "암호가 설정 되었습니다.")
                    let PinNumberSettingViewController = PinNumberSettingViewController()
                    
                    self.view.addSubview(toast)
                    
                    toast.snp.makeConstraints{ make in
                        make.leading.equalToSuperview().offset(81)
                        make.trailing.equalToSuperview().offset(-81)
                        make.bottom.equalToSuperview().offset(-20)
                    }
                    
                    UIView.animate(withDuration: 1.0, delay: 1.8, options: .curveEaseOut, animations: {
                        toast.alpha = 0.0
                    }, completion: {(isCompleted) in
                        toast.removeFromSuperview()
                    })
     
                    
                    //이미지 보이기 위해 딜레이
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        //비밀번호 같다면 설정화면으로 넘어가기
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                } else {
                    //같지 않다면 배열 지워주고, 다시 입력 페이지로 돌아가기
                    
                    //이미지 보이기 위한 딜레이
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) { [self] in
                        
                        passwordArr2.removeAll()
                        mainView.newAppPwtext.isHidden = true
                        mainView.newAppPwtext2.isHidden = true
                        mainView.pwnotcorrect.isHidden = false
                        
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
    }
    
    //다시 입력 페이지
    
    @objc func wrongPwInput(sender : UIButton) {
        
        if mainView.pwnotcorrect.isHidden == false {
            
            //숫자버튼 누름면 타이틀 값(숫자) 배열에 저장, 비교를 위해 확인 입력 에서 지웠던 배열(passwordArr2)에 저장
            let numdigit = sender.currentTitle!
            passwordArr2.append(numdigit)
            
            let pwarraycount = passwordArr2.count
            
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
                print(passwordArr)
                print(passwordArr2)
                
                if passwordArr == passwordArr2 {
                    defaults.set(passwordArr2, forKey: "newPasswordArr")
                    defaults.object(forKey: "newPasswordArr")
                    print(UserDefaults.standard.stringArray(forKey: "newPasswordArr"))
                    
                    let toast = ToastMessageView(message: "암호가 설정 되었습니다.")
                    let PinNumberSettingViewController = PinNumberSettingViewController()
                    
                    self.view.addSubview(toast)
                    
                    toast.snp.makeConstraints{ make in
                        make.leading.equalToSuperview().offset(81)
                        make.trailing.equalToSuperview().offset(-81)
                        make.bottom.equalToSuperview().offset(-20)
                    }
                    
                    UIView.animate(withDuration: 1.0, delay: 1.8, options: .curveEaseOut, animations: {
                        toast.alpha = 0.0
                    }, completion: {(isCompleted) in
                        toast.removeFromSuperview()
                    })
     
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        
                        //비밀번호 같다면 설정화면으로 돌아가기
                        self.navigationController?.popViewController(animated: true)
   }
                    
                    
                } else {
                    passwordArr2.removeAll()
                    mainView.newAppPwtext.isHidden = true
                    mainView.newAppPwtext2.isHidden = true
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
    }
    
    //처음 비밀번호 확인페이지에서 deletBtn누를 때 배열 passwordArr항목 지우기

    @objc
    func deletBtndidtab(sender : UIButton) {
        
        let pwarraycount = passwordArr.count
        
        if mainView.newAppPwtext.isHidden == false{
            
            if mainView.deletBtn.isTouchInside {
                switch pwarraycount {
                case 4 :
                    mainView.inputNotPw4.isHidden = false
                    mainView.inputPw4.isHidden = true
                    passwordArr.removeLast()
                    
                case 3 :
                    mainView.inputNotPw3.isHidden = false
                    mainView.inputPw3.isHidden = true
                    passwordArr.removeLast()
                    
                case 2 :
                    mainView.inputNotPw2.isHidden = false
                    mainView.inputPw2.isHidden = true
                    passwordArr.removeLast()
                    
                case 1 :
                    mainView.inputNotPw1.isHidden = false
                    mainView.inputPw1.isHidden = true
                    passwordArr.removeLast()
                    
                default :
                    return
                }
            }
        }
    }
    
    //확인입력, 다시입력 비밀번호 확인페이지에서 deletBtn누를 때 배열 passwordArr2항목 지우기
    //같은 버튼에 타겟이라 상황 설정
    
    @objc
    func deletBtndidtab2(sender : UIButton) {
        
        if mainView.newAppPwtext2.isHidden == false ||
            mainView.pwnotcorrect.isHidden == false {
            
            let pwarraycount = passwordArr2.count
            
            if mainView.deletBtn.isTouchInside {
                switch pwarraycount {
                case 4 :
                    mainView.inputNotPw4.isHidden = false
                    mainView.inputPw4.isHidden = true
                    passwordArr2.removeLast()
                    print(passwordArr2)

                    
                case 3 :
                    mainView.inputNotPw3.isHidden = false
                    mainView.inputPw3.isHidden = true
                    passwordArr2.removeLast()
                    print(passwordArr2)

                    
                case 2 :
                    mainView.inputNotPw2.isHidden = false
                    mainView.inputPw2.isHidden = true
                    passwordArr2.removeLast()
                    print(passwordArr2)

                    
                case 1 :
                    mainView.inputNotPw1.isHidden = false
                    mainView.inputPw1.isHidden = true
                    passwordArr2.removeLast()
                    print(passwordArr2)

                    
                default :
                    return
                }
            }
        }
    }
}



