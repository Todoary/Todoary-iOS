//
//  DiaryTabelViewCell.swift
//  Todoary
//
//  Created by 예리 on 2022/07/30.
//

import Foundation
import SnapKit
import UIKit

protocol DiaryTodoCellDelegate{
    func requestPatchTodoCheckStatus(cell: TodoInDiaryTableViewCell)
}

class TodoInDiaryTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "DiaryTabelViewCell"
    
    var cellData : TodoResultModel!
    var delegate: DiaryTodoCellDelegate!
    
    //tableCell UI
    lazy var checkBox = UIButton().then{
        $0.setImage(Image.todoCheckEmpty, for: .normal)
        $0.setImage(Image.todoCheck, for: .selected)
        $0.addTarget(self, action: #selector(checkBoxBtnDidClicked), for: .touchUpInside)
    }
    
    let titleLabel = UILabel().then{
        $0.textColor = .black
        $0.setTypoStyleWithSingleLine(typoStyle: .bold15_18)
    }
    
    lazy var categoryButton = UIButton().then{
        $0.titleLabel?.setTypoStyleWithSingleLine(typoStyle: .bold12)
        $0.titleLabel?.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 21/2
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 13, bottom: 3, right: 11)
        $0.isEnabled = false
    }
    
    lazy var alarmImage = UIImageView().then{
        $0.image = Image.notifications
    }
    
    let timeLabel = UILabel().then{
        $0.text = "AM 7:00"
        $0.textColor = .timeColor
        $0.setTypoStyleWithSingleLine(typoStyle: .medium13)
    }
    
    let backView = UIView().then{
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .white
        $0.layer.shadowRadius = 5.0
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.selectionStyle = .none
        
        setUpView()
        setUpConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func checkBoxBtnDidClicked(){
        delegate.requestPatchTodoCheckStatus(cell: self)
        
        /*
        let parameter = TodoCheckboxInput(todoId: cellData.todoId, isChecked: !self.checkBox.isSelected)
        
        TodoCheckboxDataManager().patch(cell: self, parameter: parameter)
         */
    }
    /*
    func checkCheckBoxApiResultCode(code: Int){
        if(code == 1000){
            self.checkBox.isSelected.toggle()
        }else{
            let alert = DataBaseErrorAlert()
            self.navigationController.present(alert, animated: true, completion: nil)
        }
    }
     */
}

