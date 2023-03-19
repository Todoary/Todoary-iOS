//
//  AddButtonView.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/27.
//

import UIKit

class AddButtonViewController: UIViewController{
    
    //MARK: - Properties
    var delegate: AddButtonClickProtocol!
    
    var detent: DetentIdentifier!
    
    enum DetentIdentifier{
        case low
        case high
    }
    
    //MARK: - UI
    
    let buttonView = UIView().then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .calendarSelectColor
        $0.layer.shadowRadius = 5.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 5)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    lazy var addTodoBtn = UIButton().then{
        $0.setImage(Image.addTodo, for: .normal)
        $0.addTarget(self, action: #selector(addTodoBtnDidClicked), for: .touchUpInside)
    }
    
    lazy var addDiaryBtn = UIButton().then{
        $0.setImage(Image.addDiary, for: .normal)
        $0.addTarget(self, action: #selector(addDiaryBtnDidClicked), for: .touchUpInside)
    }
    
    let borderLine = UIView().then{
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let dissmissTap = UITapGestureRecognizer(target: self, action: #selector(willDismissView))
        self.view.addGestureRecognizer(dissmissTap)
        
        self.view.addSubview(buttonView)
        
        buttonView.addSubview(addTodoBtn)
        buttonView.addSubview(borderLine)
        buttonView.addSubview(addDiaryBtn)
        
        addTodoBtn.snp.makeConstraints{
            $0.width.equalTo(44)
            $0.height.equalTo(43)
            $0.leading.equalToSuperview().offset(3)
            $0.trailing.equalToSuperview().offset(-3)
            $0.top.equalToSuperview().offset(7)
        }
        
        borderLine.snp.makeConstraints{
            $0.top.equalTo(addTodoBtn.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.height.equalTo(1)
        }
        
        addDiaryBtn.snp.makeConstraints{
            $0.width.equalTo(44)
            $0.height.equalTo(43)
            $0.leading.equalToSuperview().offset(3)
            $0.trailing.equalToSuperview().offset(-3)
            $0.top.equalTo(borderLine).offset(12)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        buttonView.snp.makeConstraints{
            $0.height.equalTo(120)
            $0.width.equalTo(50)
            $0.trailing.equalToSuperview().offset(-61)
            
            if(detent == DetentIdentifier.low){
                let location: CGFloat = Const.Device.isSmallDevice ? 431.22 + 65 : 519 + 41
                let bottomHeight = Const.Device.DEVICE_HEIGHT - location //519 + 41
                $0.bottom.equalToSuperview().offset(-(bottomHeight))
            }else{
                let location = Const.Device.isSmallDevice ? 83.28 + 35 : 95 + 41
                let bottomHeight = location + 40 //519 + 41
                $0.top.equalToSuperview().offset((bottomHeight))
            }
        
        }
    }
    
    @objc func willDismissView(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func addTodoBtnDidClicked(){
        delegate.willMoveAddTodo()
    }
    
    @objc func addDiaryBtnDidClicked(){
        delegate.willMoveAddDiary()
    }
}

protocol AddButtonClickProtocol{
    func willMoveAddTodo()
    func willMoveAddDiary()
}
