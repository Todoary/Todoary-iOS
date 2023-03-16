//
//  BaseViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/02.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let navigationView = UIView()
    
    final lazy var backBtn = UIButton().then{
        $0.setImage(Image.backArrow, for: .normal)
        $0.addTarget(self, action: #selector(backButtonDidClicked(_:)), for: .touchUpInside)
    }
    
    final let navigationTitle = UILabel().then{
        $0.setTypoStyleWithSingleLine(typoStyle: .semibold18)
        $0.textColor = .black
    }
    
    lazy var rightButton = UIButton().then{
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: .semibold18)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        initialize()
    }
    
    func style(){
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func layout(){
        self.view.addSubview(navigationView)
        
        navigationView.addSubview(backBtn)
        navigationView.addSubview(navigationTitle)
        
        navigationView.snp.makeConstraints{
            let offset = Const.Device.isSmallDevice ? 20 : 40
            $0.top.equalToSuperview().offset(offset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        backBtn.snp.makeConstraints{ make in
            make.width.equalTo(61)
            make.leading.top.bottom.equalToSuperview()
        }
        
        navigationTitle.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func initialize() { }
    
    func setRightButtonWithText(_ text: String){
        
        rightButton.setTitle(text, for: .normal)
        
        navigationView.addSubview(rightButton)
        
        rightButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-23.86)
            $0.width.height.equalTo(rightButton.titleLabel!)
        }
    }
    
    func setRightButtonWithImage(_ image: UIImage!){
        
        rightButton.setImage(image, for: .normal)
        
        navigationView.addSubview(rightButton)
        
        rightButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(2)
            $0.height.equalToSuperview()
            $0.width.equalTo(60.84)
            $0.trailing.equalToSuperview().offset(-18.95)
        }
    }
    
    @objc func backButtonDidClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    final func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(noti:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    final func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillAppear(noti: NSNotification) {
    }

    @objc func keyboardWillDisappear(noti: NSNotification) {
        self.view.transform = .identity
    }
    
    @objc func viewDidTapped(){
        self.view.endEditing(true)
    }

}

extension BaseViewController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("swipe gesture recognize")
        return navigationController?.viewControllers.count ?? 0 > 1
    }
}
