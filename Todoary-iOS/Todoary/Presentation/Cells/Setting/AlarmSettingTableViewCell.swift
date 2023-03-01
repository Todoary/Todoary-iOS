//
//  AlarmSettingTableViewCell.swift
//  Todoary
//
//  Created by 박지윤 on 2022/07/10.
//

import UIKit

class AlarmSettingTableViewCell: UITableViewCell {
    
    var alarmType: AlarmType!
    
//    var navigation: UINavigationController!
    
    let backView = UIView()
    
    let cellTitle = UILabel().then{
        $0.labelTypeSetting(type: .tableCell)
        $0.text = "Todoary 알림"
    }
    let alarmSwitch = UISwitch().then{
        $0.addTarget(self, action: #selector(alarmSwitchWillChangeState), for: .valueChanged)
    }
    
    let infoBtn = UIButton().then{
        $0.setImage(Image.help, for: .normal)
    }
    let separatorLine = UIView().then{
        $0.backgroundColor = .silver_225
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpConstraint()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
    
        self.contentView.addSubview(backView)
        
        self.backView.addSubview(cellTitle)
        self.backView.addSubview(alarmSwitch)
        self.backView.addSubview(infoBtn)
        self.backView.addSubview(separatorLine)
    }
    
    func setUpConstraint(){
        
        self.contentView.snp.makeConstraints{ make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
        
        backView.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        cellTitle.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(31)
            make.centerY.equalToSuperview()
        }
        
        alarmSwitch.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(27)
            make.width.equalTo(44)
            make.centerY.equalToSuperview().offset(-1)
        }
        
        infoBtn.snp.makeConstraints{ make in
            make.width.height.equalTo(16.67)
            make.centerY.equalTo(cellTitle)
            make.leading.equalTo(cellTitle.snp.trailing).offset(6.67)
        }
        
        separatorLine.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview().offset(-31)
            make.height.equalTo(1)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
          contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    @objc func alarmSwitchWillChangeState(){
        print("LOG: REQUEST alarmSwitchWillChangeState", alarmType, alarmSwitch.isOn)
        switch alarmType {
        case .Todoary:
            AlarmService.shared.modifyTodoAlarmActiveStatus(request: self.alarmSwitch.isOn, completion: { result in
                self.processResponsePatchAlarmStatus(result: result)
            })
        case .Diary:
            AlarmService.shared.modifyDiaryAlarmActiveStatus(request: self.alarmSwitch.isOn, completion: { result in
                self.processResponsePatchAlarmStatus(result: result)
            })
        case .Remind:
            AlarmService.shared.modifyRemindAlarmActiveStatus(request: self.alarmSwitch.isOn, completion: { result in
                self.processResponsePatchAlarmStatus(result: result)
            })
        default:
            return
        }
    }
    
    func processResponsePatchAlarmStatus(result: NetworkResult<Any>){
        switch result{
        case .success:
            print("LOG: SUCCESS processResponsePatchAlarmStatus", result, alarmType)
            break
        default:
            print("LOG: FAIL processResponsePatchAlarmStatus", result)
            self.alarmSwitch.setOn(!alarmSwitch.isOn, animated: true)
            break
        }
    }
}

class CellButtonTapGesture: UITapGestureRecognizer{
    var caller: Int?
}

