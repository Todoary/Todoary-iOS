//
//  PinNumberSettingViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/08/14.
//

import UIKit
import SnapKit
import Then

class PinNumberSettingViewController : BaseViewController {
    
    //MARK: - UIComponents
    
    let pinTitle = UILabel().then{
        $0.text = "암호 설정"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let pinSwitch = UISwitch().then{
        $0.addTarget(self, action: #selector(onClickSwitch(sender:)), for: .valueChanged)

    }
    
    let pinBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    let backView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let pinSetting = UILabel().then{
        $0.text = "암호 변경"
        $0.textColor = .black
        $0.addLetterSpacing(spacing: 0.28)
        $0.font = UIFont.nbFont(type: .body2)
    }
    
    let nextBtn = UIButton().then{
        $0.setImage(UIImage(named: "next_btn"), for: .normal)
        $0.addTarget(self, action: #selector(nextBtnDidTap), for: .touchUpInside)
    }
    
    let pinSettingBorderLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitle.text = "암호"

        self.view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextBtnDidTap(sender:)))
        
        
        backView.addGestureRecognizer(tapGesture)
        
        setUpView()
        setUpConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "appPasswordCheck") == true {
            pinSwitch.isOn = true
        }else {
            pinSwitch.isOn = false
        }
    }
    
    //MARK: - Actions
    
    //다음 버튼 누르기 -> 암호변경 화면
    
    @objc func nextBtnDidTap(sender: UITapGestureRecognizer) {
        let newAppPasswordViewController = NewAppPasswordViewController()
        self.navigationController?.pushViewController(newAppPasswordViewController, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //알람 uiswitch 변경 제스쳐
    @objc func onClickSwitch(sender: UISwitch) {
        if sender.isOn {
            if UserDefaults.standard.stringArray(forKey: "newPasswordArr") == nil{
                let newAppPasswordViewController = NewAppPasswordViewController()
                self.navigationController?.pushViewController(newAppPasswordViewController, animated: true)
                self.navigationController?.isNavigationBarHidden = true
            }
            UserDefaults.standard.set(true, forKey: "appPasswordCheck")
        }else {
            UserDefaults.standard.set(false,forKey: "appPasswordCheck")
        }
    }
}
