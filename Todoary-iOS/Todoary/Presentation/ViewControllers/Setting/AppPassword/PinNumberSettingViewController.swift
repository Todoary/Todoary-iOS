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
    
    //TODO: 비밀번호 설정안하고 백 한 경우에 뭐 알아서 설정되는거 같은디..?
    
    let mainView = PinNumberSettingView()
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "appPasswordCheck") == true {
            mainView.pinSwitch.isOn = true
        }else {
            mainView.pinSwitch.isOn = false
        }
    }
    
    override func style() {
        super.style()
        navigationTitle.text = "암호"
    }
    
    override func layout(){
        
        super.layout()
        
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(Const.Offset.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func initialize() {
        
        mainView.pinSwitch.addTarget(self, action: #selector(onClickSwitch(sender:)), for: .valueChanged)
        mainView.nextBtn.addTarget(self, action: #selector(nextBtnDidTap), for: .touchUpInside)
        
        mainView.backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextBtnDidTap(sender:))))
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
