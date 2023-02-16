//
//  BaseAlertViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/20.
//

import UIKit

class BaseAlertViewController: UIViewController {
    
    init(title: String){
        self.titleLabel.text = title
        super.init(nibName: nil, bundle: nil)
    }
    
    var alertHandler: (() -> ())!
    
    //MARK: - UI
    
    let titleLabel = UILabel().then{
        $0.font = UIFont.nbFont(ofSize: 17, weight: .bold, type: .apple)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.labelAttributeSetting(letterSpacing: -0.41, lineHeight: 22)
    }
    
    lazy var confirmBtn = UIButton().then{
        $0.layer.cornerRadius = 11
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 20/255, green: 37/255, blue: 83/255, alpha: 1)
        $0.titleLabel?.font = UIFont.nbFont(ofSize: 17, weight: .semibold, type: .apple)
//        $0.titleEdgeInsets = UIEdgeInsets(top: 9, left: 0, bottom: 8, right: 0)
        $0.titleLabel?.textAlignment = .center
        $0.addTarget(self, action: #selector(confirmBtnDidClicked), for: .touchUpInside)
    }
    
    let containerView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 14
    }
    
    let btnStackView = UIStackView().then{
        $0.spacing = 10
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpInitSetting()
        setUpView()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        // curveEaseOut: 시작은 천천히, 끝날 땐 빠르게
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)

        // curveEaseIn: 시작은 빠르게, 끝날 땐 천천히
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.containerView.transform = .identity
            self?.containerView.isHidden = true
        }
    }
    
    func setUpInitSetting(){
        
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlertController))
        gesture.delegate = self
        
        self.view.addGestureRecognizer(gesture)
    }
    
    func setUpView(){
        
        self.view.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(btnStackView)
        
        btnStackView.addArrangedSubview(confirmBtn)
    }
    
    func setUpConstraint(){
        
        containerView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview().offset(-2)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
        }
        
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().offset(-17)
        }
        
        btnStackView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().offset(-17)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        confirmBtn.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.height.equalTo(confirmBtn.titleLabel!).offset(18)
        }
        
    }
    
    //MARK: - Action
    
    @objc func dismissAlertController(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func confirmBtnDidClicked(){
        self.alertHandler?()
        self.dismiss(animated: false, completion: nil)
    }
    
    func show(in viewController: UIViewController) -> Self{
        self.modalPresentationStyle = .overFullScreen
        viewController.present(self, animated: false)
        return self
    }

}

extension BaseAlertViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard touch.view?.isDescendant(of: self.containerView) == false else { return false }
        
        return true
    }
}
