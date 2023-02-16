//
//  AlarmAlertViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/09/26.
//

import UIKit

class AlarmAlertViewController: UIViewController {
    
    //MARK: - Properties
    
    var pickTime = [0,0,0] //0: hour, 1: minute, 2: am/pm
    
    var todoData: TodoResultModel!{
        didSet{
            setPickerTime()
        }
    }
    
    var targetTime: String!
    var completion: ((TodoAlarmRequestModel)->Void)!
    
    //MARK: - UI
    
    let containerView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 14
    }
    
    let timePicker = UIPickerView()
    
    lazy var confirmBtn = UIButton().then{
        $0.setTitle("확인", for: .normal)
        $0.layer.cornerRadius = 11
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 20/255, green: 37/255, blue: 83/255, alpha: 1)
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: .semibold17)
        $0.titleEdgeInsets = UIEdgeInsets(top: 9, left: 0, bottom: 8, right: 0)
        $0.titleLabel?.textAlignment = .center
        $0.addTarget(self, action: #selector(confirmBtnDidClicked), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpInitSetting()
        setUpView()
        setUpConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        timePicker.selectRow(pickTime[0], inComponent: 0, animated: true)
        timePicker.selectRow(pickTime[1], inComponent: 1, animated: true)
        timePicker.selectRow(pickTime[2], inComponent: 2, animated: true)

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
        
        self.timePicker.delegate = self
    }
    
    func setUpView(){
        
        self.view.addSubview(containerView)
        
        containerView.addSubview(timePicker)
        containerView.addSubview(confirmBtn)
        
    }
    
    func setUpConstraint(){
        
        containerView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(336)
            make.bottom.equalToSuperview().offset(-252)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
            make.height.equalTo(256)
        }
        
        timePicker.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-32.15)
            $0.top.equalToSuperview().offset(25)
            $0.height.equalTo(153)
        }

        confirmBtn.snp.makeConstraints{
            $0.top.equalTo(timePicker.snp.bottom).offset(15.28)
            $0.leading.equalToSuperview().offset(21.66)
            $0.trailing.equalToSuperview().offset(-22.34)
            $0.bottom.equalToSuperview().offset(-12.72)
            $0.height.equalTo(50)
        }
        
    }
    
    func setPickerTime(){
        
        guard let time = todoData.targetTime else { return }
        
        let timeArray = time.components(separatedBy: ":").map({ Int($0)! })
        
        let firstComponent = timeArray[0] % 12 != 0 ? timeArray[0] % 12 - 1 : 11
        let thirdComponent = time < "12:00" ? 0 : 1
        
        pickTime = [firstComponent, timeArray[1], thirdComponent]
    }
    
    //MARK: - Action
    
    @objc func dismissAlertController(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func confirmBtnDidClicked(){
        
        var hour: String {
            if(pickTime[2] == 1){
                return "\(pickTime[0] + 13)"
            }else if(pickTime[0] < 9){
                return "0\(pickTime[0] + 1)"
            }else if(pickTime[0] < 11){
                return "\(pickTime[0] + 1)"
            }else{
                return "00"
            }
        }
        
        let minute = pickTime[1] < 10 ? String("0\(pickTime[1])") : String(pickTime[1])
        
        self.targetTime = "\(hour):\(minute)"
        
        let parameter = TodoAlarmRequestModel(targetDate: todoData.targetDate,
                                              isAlarmEnabled: true,
                                              targetTime: targetTime)
        completion(parameter)
    }
}

extension AlarmAlertViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        3
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        switch component{
        case 0:
            return 12
        case 1:
            return 60
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat{
        switch component{
        case 0:
            return 47
        case 1:
            return 53
        case 2:
            return 62
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        36
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        switch component{
        case 0:
            return String(row + 1)
        case 1:
            return row < 10 ? String("0\(row)") : String(row)
        case 2:
            return row == 0 ? "AM" : "PM"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickTime[component] = row
    }
}

extension AlarmAlertViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        guard touch.view?.isDescendant(of: self.containerView) == false else { return false }
        
        return true
    }
}

